import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/grade_converter.dart';
import 'package:sistime_portal/core/helper/secure_storage.dart';
import 'package:sistime_portal/features/profil/data/datasources/local_datasource.dart';
import 'package:sistime_portal/features/profil/data/models/profil_model.dart';
import 'package:sistime_portal/features/transkrip/domain/entities/transkrip.dart';
import 'package:sistime_portal/features/transkrip/domain/usecases/get_transkrip.dart';
import 'package:sistime_portal/core/localization/l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:sistime_portal/features/login/data/datasources/login_local_data_source.dart';

part 'transkrip_event.dart';
part 'transkrip_state.dart';

class TranskripBloc extends Bloc<TranskripEvent, TranskripState> {
  final GetTranskrip _getTranskrip;
  final ProfilLocalDataSource _profilLocalDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  TranskripBloc({
    required GetTranskrip getTranskrip,
    required ProfilLocalDataSource profilLocalDataSource,
    required this.loginLocalDataSource,
  }) : _getTranskrip = getTranskrip,
       _profilLocalDataSource = profilLocalDataSource,
       super(TranskripInitial()) {
    on<GetListTranskrip>((event, emit) async {
      emit(TranskripLoading());
      try {
        final profil = await _profilLocalDataSource.getSavedProfilData();
        final username = await SecureStorage().getData('username');
        final result = await _getTranskrip.execute(profil!.idUser.toString());
        await result.fold(
          (failure) async {
            if (failure.type == MessageExcType.tokenExpired) {
              await loginLocalDataSource.deleteToken();
              emit(TranskripTokenExpired(message: failure.message));
            } else {
              emit(TranskripError(message: failure.message));
            }
          },
          (data) async {
            int passedCourses = 0;
            int failedCourses = 0;
            int totalSks = 0;
            double totalBobot = 0;

            // Create a new list to hold the enriched data
            final List<Transkrip> enrichedTranskripList = [];

            for (var transkrip in data) {
              final nilai = transkrip.nilai;
              String? currentLetterGrade;
              final minRequiredScores = [
                nilai?.quiz,
                nilai?.uts,
                nilai?.uas,
                nilai?.absensi,
              ];
              totalSks += transkrip.sks;

              if (nilai != null) {
                if (nilai.perbaikan != null) {
                  currentLetterGrade = konversiNilaiKeHuruf(nilai.perbaikan!);
                  totalBobot += getBobot(currentLetterGrade) * transkrip.sks;
                } else {
                  final List<double?> scores = [
                    nilai.tugas,
                    nilai.uts,
                    nilai.uas,
                    nilai.absensi,
                    nilai.project,
                    nilai.quiz,
                  ];
                  final List<double> validScores = scores
                      .whereType<double>()
                      .toList();
                  if (validScores.isNotEmpty) {
                    final double totalScore = validScores.reduce(
                      (a, b) => a + b,
                    );
                    final int count = validScores.length;
                    if (count >= minRequiredScores.length) {
                      final double averageScore = totalScore / count;
                      currentLetterGrade = konversiNilaiKeHuruf(averageScore);
                    } else {
                      currentLetterGrade = 'E';
                    }
                    totalBobot += getBobot(currentLetterGrade) * transkrip.sks;
                  }
                }
              }

              if (currentLetterGrade == 'A' ||
                  currentLetterGrade == 'B' ||
                  currentLetterGrade == 'C') {
                passedCourses++;
              } else {
                failedCourses++;
              }

              enrichedTranskripList.add(
                transkrip.copyWith(letterGrade: currentLetterGrade),
              );
            }

            final double gpa = totalSks > 0 ? totalBobot / totalSks : 0;
            emit(
              TranskripLoaded(
                profil: profil,
                username: username,
                listTranskrip: enrichedTranskripList,
                passedCourses: passedCourses,
                failedCourses: failedCourses,
                totalSks: totalSks,
                gpa: gpa,
              ),
            );
          },
        );
      } catch (e) {
        emit(TranskripError(message: e.toString()));
      }
    });

    on<DownloadTranskripPdf>((event, emit) async {
      final currentState = state;
      final profil = await _profilLocalDataSource.getSavedProfilData();
      final username = await SecureStorage().getData('username');
      if (currentState is TranskripLoaded && profil != null) {
        emit(TranskripLoading());
        try {
          final AppLocalizations appLocalizations = event.appLocalizations;
          final pdf = pw.Document();
          final ByteData bytes = await rootBundle.load('images/logo_stmik.png');
          final Uint8List imageBytes = bytes.buffer.asUint8List();
          final List<List<String>> tableData = List.generate(
            currentState.listTranskrip.length,
            (index) {
              final transkrip = currentState.listTranskrip[index];
              return [
                (index + 1).toString(),
                transkrip.kodeMatkul,
                transkrip.matkul,
                transkrip.sks.toString(),
                transkrip.letterGrade ?? '',
              ];
            },
          );
          final int timestamp = DateTime.now().millisecondsSinceEpoch;
          final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
          final String formattedDate = DateFormat(
            'dd-MM-yyyy, HH:mm:ss',
            'id_ID',
          ).format(date);
          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4,
              maxPages: 100,
              build: (pw.Context context) {
                return [
                  pw.Header(
                    level: 0,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

                      children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Image(
                                pw.MemoryImage(imageBytes),
                                width: 80,
                                height: 80,
                              ),
                              pw.Text(
                                'Studi STMIK Time\nJalan Merbabu No. 32 blok AA-BB Medan\ntelp: (061) 4561932 email: stmiktime@gmail.com',
                                style: pw.TextStyle(fontSize: 12),
                                textAlign: pw.TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        pw.Flexible(
                          child: pw.Text(
                            'created on: $formattedDate',
                            style: pw.TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.Text(
                    appLocalizations.studyPlanCard,
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(10),
                    margin: const pw.EdgeInsets.only(bottom: 10),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: pw.BorderRadius.circular(10),
                      border: pw.Border.all(
                        color: PdfColor.fromInt(0x96000000),
                      ),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('${appLocalizations.nim}: $username'),
                        pw.Text(
                          '${appLocalizations.name}: ${profil.namaMahasiswa}',
                        ),

                        pw.Text(
                          '${appLocalizations.studyPrograms}: ${profil.programStudi?.namaProgramstudi}',
                        ),
                        pw.Text(
                          '${appLocalizations.roomClass}: ${profil.statusMahasiswa?.kodeKelas}',
                        ),
                      ],
                    ),
                  ),
                  pw.TableHelper.fromTextArray(
                    headers: [
                      appLocalizations.no,
                      appLocalizations.courseCode,
                      appLocalizations.course,
                      appLocalizations.sks,
                      appLocalizations.grade,
                    ],
                    headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                    cellStyle: pw.TextStyle(fontSize: 12),
                    data: tableData,
                  ),
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(10),
                    margin: const pw.EdgeInsets.only(top: 10),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: pw.BorderRadius.circular(10),
                      border: pw.Border.all(
                        color: PdfColor.fromInt(0x96000000),
                      ),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(appLocalizations.summary),
                        pw.Text(
                          '${appLocalizations.numberOfCoursesPassed}: ${currentState.passedCourses}',
                        ),
                        pw.Text(
                          '${appLocalizations.numberOfCoursesNotPassed}: ${currentState.failedCourses}',
                        ),
                        pw.Text(
                          '${appLocalizations.numberofCredits}: ${currentState.totalSks}',
                        ),
                        pw.Text(
                          '${appLocalizations.gpa}: ${currentState.gpa.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          );

          final output = await getTemporaryDirectory();
          final file = File("${output.path}/transkrip_$timestamp.pdf");
          await file.writeAsBytes(await pdf.save());
          OpenFile.open(file.path);

          emit(TranskripPdfDownloaded(filePath: file.path));
        } catch (e) {
          emit(
            TranskripError(message: 'Failed to generate PDF: ${e.toString()}'),
          );
        }
      } else {
        emit(
          TranskripError(
            message: 'Transkrip data not loaded. Please load transkrip first.',
          ),
        );
      }
    });
  }
}

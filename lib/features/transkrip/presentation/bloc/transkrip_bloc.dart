import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/domain/function/grade_converter.dart';
import 'package:newsistime/features/transkrip/domain/usecases/get_transkrip.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'transkrip_event.dart';
part 'transkrip_state.dart';

class TranskripBloc extends Bloc<TranskripEvent, TranskripState> {
  double _getBobot(String letterGrade) {
    switch (letterGrade) {
      case 'A':
        return 4.0;
      case 'B':
        return 3.0;
      case 'C':
        return 2.0;
      case 'D':
        return 1.0;
      default:
        return 0.0;
    }
  }

  final GetTranskrip _getTranskrip;
  final ProfilBloc _profilBloc;

  TranskripBloc({
    required GetTranskrip getTranskrip,
    required ProfilBloc profilBloc,
  }) : _getTranskrip = getTranskrip,
       _profilBloc = profilBloc,
       super(TranskripInitial()) {
    on<GetListTranskrip>((event, emit) async {
      final profilState = _profilBloc.state;
      if (profilState is ProfilLoaded) {
        emit(TranskripLoading());
        try {
          final username = profilState.profil.user.username;
          final result = await _getTranskrip.execute(username);
          result.fold(
            (failure) {
              emit(TranskripError(message: failure.message));
            },
            (data) {
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
                  final List<double?> scores = [
                    nilai.tugas,
                    nilai.uts,
                    nilai.uas,
                    nilai.absensi,
                    nilai.project,
                    nilai.quiz,
                    nilai.perbaikan,
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

                    totalBobot += _getBobot(currentLetterGrade) * transkrip.sks;
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
      } else {
        emit(
          TranskripError(
            message:
                'Data profil tidak ditemukan. Muat data profil terlebih dahulu.',
          ),
        );
      }
    });

    on<DownloadTranskripPdf>((event, emit) async {
      final currentState = state;
      final profilState = _profilBloc.state;
      if (currentState is TranskripLoaded && profilState is ProfilLoaded) {
        emit(TranskripLoading());
        try {
          final AppLocalizations appLocalizations = event.appLocalizations;
          final pdf = pw.Document();

          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                return [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        appLocalizations.valueTranscript,
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
                            pw.Text(
                              '${appLocalizations.nim}: ${profilState.profil.data.nim}',
                            ),
                            pw.Text(
                              '${appLocalizations.name}: ${profilState.profil.data.nama}',
                            ),
                            pw.Text(
                              '${appLocalizations.roomClass}: ${profilState.profil.data.kelas}',
                            ),
                            pw.Text(
                              '${appLocalizations.studyPrograms}: ${profilState.profil.data.prodi}',
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
                        data: currentState.listTranskrip.map((t) {
                          return [
                            (currentState.listTranskrip.indexOf(t) + 1)
                                .toString(),
                            t.kodeMatkul,
                            t.matkul,
                            t.sks.toString(),
                            t.letterGrade ?? 'N/A',
                          ];
                        }).toList(),
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
                    ],
                  ),
                ];
              },
            ),
          );

          final output = await getTemporaryDirectory();
          final String timestamp = DateTime.now().millisecondsSinceEpoch
              .toString();
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

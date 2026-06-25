import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:sistime_portal/core/error/message_exc.dart';
import 'package:sistime_portal/core/helper/grade_converter.dart';
import 'package:sistime_portal/core/helper/secure_storage.dart';
import 'package:sistime_portal/features/khs/domain/entities/khs.dart';
import 'package:sistime_portal/features/khs/domain/usecases/get_khs.dart';
import 'package:sistime_portal/features/login/data/datasources/login_local_data_source.dart';
import 'package:sistime_portal/features/profil/data/datasources/local_datasource.dart';
import 'package:sistime_portal/features/profil/domain/entities/profil.dart';
import 'package:sistime_portal/core/localization/l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'khs_event.dart';
part 'khs_state.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  final GetKhs getKhs;
  final ProfilLocalDataSource profilLocalDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  KhsBloc({
    required this.getKhs,
    required this.profilLocalDataSource,
    required this.loginLocalDataSource,
  }) : super(KhsInitial()) {
    on<FetchKhsData>((event, emit) async {
      final profil = await profilLocalDataSource.getSavedProfilData();
      final username = await SecureStorage().getData('username');
      emit(KhsLoading());
      try {
        final khsResult = await getKhs.call(id: profil!.idUser.toString());
        await khsResult.fold(
          (failure) async {
            if (failure.type == MessageExcType.tokenExpired) {
              await loginLocalDataSource.deleteToken();
              emit(KhsTokenExpired(message: failure.message));
            } else {
              emit(KhsError(message: failure.message));
            }
          },
          (data) {
            final groupedKhs = <int, List<Khs>>{};
            for (var khs in data) {
              final semester = khs.semester;
              if (!groupedKhs.containsKey(semester)) {
                groupedKhs[semester] = [];
              }
              final nilai = khs.nilais;
              final minRequiredScores = [
                nilai?.quiz,
                nilai?.uts,
                nilai?.uas,
                nilai?.absensi,
              ];
              String? currentLetterGrade;
              if (nilai != null) {
                if (nilai.perbaikan != null) {
                  currentLetterGrade = konversiNilaiKeHuruf(nilai.perbaikan!);
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
                  }
                }
              }
              final khsWithGrade = khs.copyWith(
                letterGrade: currentLetterGrade,
              );
              groupedKhs[semester]!.add(khsWithGrade);
            }
            final sortedGroupKhs = Map.fromEntries(
              groupedKhs.entries.toList()
                ..sort((a, b) => a.key.compareTo(b.key)),
            );
            emit(
              KhsLoaded(
                groupedKhs: sortedGroupKhs,
                profil: profil.toEntity(),
                username: username,
              ),
            );
          },
        );
      } catch (e) {
        emit(KhsError(message: e.toString()));
      }
    });

    on<DownloadKhsPdf>((event, emit) async {
      final currentState = state;
      KhsLoaded? dataState;

      if (currentState is KhsLoaded) {
        dataState = currentState;
      }

      final profil = await profilLocalDataSource.getSavedProfilData();
      final username = await SecureStorage().getData('username');

      if (dataState != null && profil != null) {
        try {
          final AppLocalizations appLocalizations = event.appLocalizations;
          final pdf = pw.Document();
          final ByteData bytes = await rootBundle.load('images/logo_stmik.png');
          final Uint8List imageBytes = bytes.buffer.asUint8List();
          final semesterData = dataState.groupedKhs[event.semester]!;
          final bool hasQuiz = semesterData.any((e) => e.nilais?.quiz != null);
          final bool hasProject = semesterData.any(
            (e) => e.nilais?.project != null,
          );
          final bool hasImprovement = semesterData.any(
            (e) => e.nilais?.perbaikan != null,
          );

          final List<String> headers = [
            appLocalizations.no,
            appLocalizations.courseCode,
            appLocalizations.course,
            appLocalizations.sks,
            if (hasQuiz) appLocalizations.quiz,
            if (hasProject) appLocalizations.project,
            appLocalizations.attendance,
            appLocalizations.assignment,
            appLocalizations.uts,
            appLocalizations.uas,
            if (hasImprovement) appLocalizations.improvement,
            appLocalizations.grade,
          ];

          final List<List<String>> data = semesterData.map((khs) {
            final List<String> row = [
              (semesterData.indexOf(khs) + 1).toString(),
              khs.kodeMatakuliah,
              khs.namaMatakuliah,
              khs.sks.toString(),
              if (hasQuiz) khs.nilais?.quiz?.toString() ?? '',
              if (hasProject) khs.nilais?.project?.toString() ?? '',
              khs.nilais?.absensi?.toString() ?? '',
              khs.nilais?.tugas?.toString() ?? '',
              khs.nilais?.uts?.toString() ?? "",
              khs.nilais?.uas?.toString() ?? "",
              if (hasImprovement) khs.nilais?.perbaikan?.toString() ?? '',
              khs.letterGrade ?? '',
            ];
            return row;
          }).toList();
          final int timestamp = DateTime.now().millisecondsSinceEpoch;
          final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
          final String formattedDate = DateFormat(
            'dd-MM-yyyy, HH:mm:ss',
            'id_ID',
          ).format(date);

          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4,
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
                    appLocalizations.studyResultsCard,
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
                          '${appLocalizations.name}: ${profil.namaMahasiswa ?? ""}',
                        ),
                        pw.Text(
                          '${appLocalizations.studyPrograms}: ${profil.programStudi?.namaProgramstudi ?? ""}',
                        ),
                        pw.Text(
                          '${appLocalizations.semester}: ${event.semester}',
                        ),
                      ],
                    ),
                  ),
                  pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: const pw.FlexColumnWidth(0.8),
                      1: const pw.FlexColumnWidth(1.5),
                      2: const pw.FlexColumnWidth(2),
                      3: const pw.FlexColumnWidth(1),
                      4: const pw.FlexColumnWidth(1.2),
                      5: const pw.FlexColumnWidth(1.2),
                      6: const pw.FlexColumnWidth(1.2),
                      7: const pw.FlexColumnWidth(1.2),
                      8: const pw.FlexColumnWidth(1.2),
                      9: const pw.FlexColumnWidth(1.2),
                      10: const pw.FlexColumnWidth(1.2),
                      11: const pw.FlexColumnWidth(1),
                    },
                    tableWidth: pw.TableWidth.max,
                    defaultVerticalAlignment:
                        pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.TableRow(
                        children: headers
                            .map(
                              (header) => pw.Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  header,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      ...data.map(
                        (row) => pw.TableRow(
                          children: row
                              .map(
                                (cell) => pw.Container(
                                  alignment: row.indexOf(cell) != 2
                                      ? pw.Alignment.center
                                      : pw.Alignment.centerLeft,
                                  padding: const pw.EdgeInsets.all(4),
                                  child: pw.Text(
                                    cell,
                                    style: pw.TextStyle(fontSize: 12),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ];
              },
            ),
          );
          final output = await getTemporaryDirectory();

          final file = File("${output.path}/Khs_$timestamp.pdf");
          await file.writeAsBytes(await pdf.save());
          OpenFile.open(file.path);

          emit(KhsPdfDownloaded(filePath: file.path));
          emit(dataState);
        } catch (e) {
          emit(KhsError(message: 'Failed to generate PDF: ${e.toString()}'));
        }
      } else {
        emit(
          KhsError(
            message: 'Transkrip data not loaded. Please load transkrip first.',
          ),
        );
      }
    });
  }
}

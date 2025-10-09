import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/krs/domain/usecases/get_mata_kuliah.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/domain/usecases/get_transkrip.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'khs_event.dart';
part 'khs_state.dart';

String konversiNilaiKeHuruf(double nilaiAkhir) {
  if (nilaiAkhir >= 90) {
    return 'A';
  } else if (nilaiAkhir >= 80) {
    return 'B';
  } else if (nilaiAkhir >= 70) {
    return 'C';
  } else if (nilaiAkhir >= 60) {
    return 'D';
  } else {
    return 'E';
  }
}

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  final GetTranskrip getTranskrip;
  final GetMataKuliah getMataKuliah;

  KhsBloc({required this.getTranskrip, required this.getMataKuliah})
    : super(KhsInitial()) {
    on<FetchKhsData>((event, emit) async {
      emit(KhsLoading());
      try {
        final khsResult = await getTranskrip.execute(event.nim);
        final matkulResult = await getMataKuliah.execute();

        final khsEither = khsResult;
        final matkulEither = matkulResult;

        if (khsEither.isLeft() || matkulEither.isLeft()) {
          final errorMessage =
              khsEither.fold((l) => l.message, (r) => '') +
              matkulEither.fold((l) => l.message, (r) => '');
          emit(KhsError(message: errorMessage));
          return;
        }

        final khsList = khsEither.getOrElse(() => []);
        final matkulList = matkulEither.getOrElse(() => []);

        final matkulMap = {
          for (var matkul in matkulList) matkul.kodeMataKuliah: matkul,
        };
        final groupedKrs = <int, List<Transkrip>>{};

        for (var khs in khsList) {
          final matkul = matkulMap[khs.kodeMatkul];
          if (matkul != null) {
            final semester = matkul.semester;
            if (!groupedKrs.containsKey(semester)) {
              groupedKrs[semester] = [];
            }

            final nilai = khs.nilai;
            String currentLetterGrade = 'N/A';

            if (nilai != null) {
              final List<double> scores = [
                nilai.tugas ?? 0,
                nilai.uts ?? 0,
                nilai.uas ?? 0,
                nilai.absensi ?? 0,
                nilai.project ?? 0,
                nilai.quiz ?? 0,
              ];
              if (scores.isNotEmpty) {
                final double averageScore =
                    scores.reduce((a, b) => a + b) /
                    (nilai.project == 0 ? scores.length : 4);
                currentLetterGrade = konversiNilaiKeHuruf(averageScore);
              }
            }

            final khsWithGrade = khs.copyWith(letterGrade: currentLetterGrade);
            groupedKrs[semester]!.add(khsWithGrade);
          }
        }

        final sortedGroupedKrs = Map.fromEntries(
          groupedKrs.entries.toList()
            ..sort((e1, e2) => e1.key.compareTo(e2.key)),
        );

        emit(KhsLoaded(groupedKhs: sortedGroupedKrs));
      } catch (e) {
        emit(KhsError(message: e.toString()));
      }
    });

    on<DownloadKhsPdf>((event, emit) async {
      final currentState = state;
      if (currentState is KhsLoaded) {
        try {
          // emit(KhsLoading()); // <-- Comment out or remove this line
          final AppLocalizations appLocalizations = event.appLocalizations;
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                // ignore: collection_methods_unrelated_type
                final semesterData = currentState.groupedKhs[event.semester]!;
                final bool hasQuiz = semesterData.any(
                  (e) => e.nilai?.quiz != null,
                );
                final bool hasProject = semesterData.any(
                  (e) => e.nilai?.project != null,
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
                  appLocalizations.grade,
                ];

                final List<List<String>> data = semesterData.map((khs) {
                  final List<String> row = [
                    (semesterData.indexOf(khs) + 1).toString(),
                    khs.kodeMatkul,
                    khs.matkul,
                    khs.sks.toString(),
                    if (hasQuiz) khs.nilai!.quiz.toString(),
                    if (hasProject) khs.nilai!.project.toString(),
                    khs.nilai!.absensi.toString(),
                    khs.nilai!.tugas.toString(),
                    khs.nilai!.uts.toString(),
                    khs.nilai!.uas.toString(),
                    khs.letterGrade ?? 'N/A',
                  ];
                  return row;
                }).toList();

                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
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
                          pw.Text('${appLocalizations.nim}: 2244068'),
                          pw.Text('${appLocalizations.name}: Felix'),
                          pw.Text('${appLocalizations.roomClass}: Ti D 22'),
                          pw.Text(
                            '${appLocalizations.studyPrograms}: Teknik Informatika',
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
                        10: const pw.FlexColumnWidth(1),
                      },
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
                                    alignment: pw.Alignment.centerLeft,
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
                  ],
                );
              },
            ),
          );
          final output = await getTemporaryDirectory();
          final String timestamp = DateTime.now().millisecondsSinceEpoch
              .toString();
          final file = File("${output.path}/Khs_$timestamp.pdf");
          await file.writeAsBytes(await pdf.save());
          OpenFile.open(file.path); // <-- Comment out or remove this line

          emit(KhsPdfDownloaded(filePath: file.path));
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

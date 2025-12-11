import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/khs/domain/entities/khs.dart';
import 'package:newsistime/features/khs/domain/usecases/get_khs.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
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
  final GetKhs getKhs;
  final ProfilBloc profilBloc;

  KhsBloc({required this.getKhs, required this.profilBloc})
    : super(KhsInitial()) {
    on<FetchKhsData>((event, emit) async {
      final profilState = profilBloc.state;
      if (profilState is ProfilLoaded) {
        emit(KhsLoading());
        try {
          final khsResult = await getKhs.call(
            id: profilState.profil.user.id.toString(),
          );
          khsResult.fold(
            (failure) {
              emit(KhsError(message: failure.message));
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
              emit(KhsLoaded(groupedKhs: sortedGroupKhs));
            },
          );
        } catch (e) {
          emit(KhsError(message: e.toString()));
        }
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
                  (e) => e.nilais?.quiz != null,
                );
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

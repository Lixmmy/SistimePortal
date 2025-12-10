import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_krs.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'krs_event.dart';
part 'krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  final GetKrs getKrs;
  final ProfilBloc profilBloc;
  // final GetMataKuliah getMataKuliah;

  KrsBloc({required this.getKrs, required this.profilBloc})
    : super(KrsInitial()) {
    on<FetchKrsData>((event, emit) async {
      final profilState = profilBloc.state;
      if (profilState is ProfilLoaded) {
        emit(KrsLoading());
        try {
          final id = profilState.profil.user.id;
          final krsResult = await getKrs.execute(id);
          krsResult.fold(
            (failure) {
              emit(KrsError(message: failure.message));
            },
            (krsList) {
              final Map<int, List<Krs>> groupedKrs = {};
              for (var krs in krsList) {
                if (!groupedKrs.containsKey(krs.semester)) {
                  groupedKrs[krs.semester] = [];
                }
                groupedKrs[krs.semester]!.add(krs);
              }
              final sortedGroupKrs = Map.fromEntries(
                groupedKrs.entries.toList()
                  ..sort((a, b) => a.key.compareTo(b.key)),
              );
              emit(KrsLoaded(groupedKrs: sortedGroupKrs));
            },
          );
        } catch (e) {
          emit(KrsError(message: e.toString()));
        }
      }
    });

    on<DownloadKrsPdf>((event, emit) async {
      final currentState = state;
      if (currentState is KrsLoaded) {
        try {
          final AppLocalizations appLocalizations = event.appLocalizations;
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                // ignore: collection_methods_unrelated_type
                final semesterData = currentState.groupedKrs[event.semester]!;

                final List<String> headers = [
                  appLocalizations.no,
                  appLocalizations.courseCode,
                  appLocalizations.course,
                  appLocalizations.lecture,
                  appLocalizations.sks,
                ];

                final List<List<String>> data = semesterData.map((krs) {
                  final List<String> row = [
                    (semesterData.indexOf(krs) + 1).toString(),
                    krs.kodeMatakuliah,
                    krs.namaMatakuliah,
                    krs.namaDosen,
                    krs.sks.toString(),
                  ];
                  return row;
                }).toList();

                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      appLocalizations.studyPlanCard,
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      children: [
                        pw.RichText(
                          text: pw.TextSpan(
                            children: [
                              pw.TextSpan(
                                text: '${appLocalizations.semester}: ',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.TextSpan(
                                text: event.semester.toString(),
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(1),
                        1: const pw.FlexColumnWidth(1.5),
                        2: const pw.FlexColumnWidth(3),
                        3: const pw.FlexColumnWidth(2),
                        4: const pw.FlexColumnWidth(1),
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
          final file = File("${output.path}/Krs_$timestamp.pdf");
          await file.writeAsBytes(await pdf.save());
          OpenFile.open(file.path); // <-- Comment out or remove this line

          emit(KrsPdfDownloaded(filePath: file.path));
        } catch (e) {
          emit(KrsError(message: 'Failed to generate PDF: ${e.toString()}'));
        }
      } else {
        emit(
          KrsError(
            message: 'Transkrip data not loaded. Please load transkrip first.',
          ),
        );
      }
    });
  }
}

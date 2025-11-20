import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_mata_kuliah.dart';
import 'package:newsistime/l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'krs_event.dart';
part 'krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  final GetKrs getKrs;
  final GetMataKuliah getMataKuliah;

  KrsBloc({required this.getKrs, required this.getMataKuliah})
    : super(KrsInitial()) {
    on<FetchKrsData>((event, emit) async {
      emit(KrsLoading());
      try {
        final krsResult = await getKrs.execute(event.nim);
        final matkulResult = await getMataKuliah.execute();

        final krsEither = krsResult;
        final matkulEither = matkulResult;

        if (krsEither.isLeft() || matkulEither.isLeft()) {
          // Handle error from either use case
          final errorMessage =
              krsEither.fold((l) => l.message, (r) => '') +
              matkulEither.fold((l) => l.message, (r) => '');
          emit(KrsError(message: errorMessage));
          return;
        }

        final krsList = krsEither.getOrElse(() => []);
        final matkulList = matkulEither.getOrElse(() => []);

        final matkulMap = {
          for (var matkul in matkulList) matkul.kodeMataKuliah: matkul,
        };
        final groupedKrs = <int, List<Krs>>{};

        for (var krs in krsList) {
          final matkul = matkulMap[krs.kodeMatakuliah];
          if (matkul != null) {
            final semester = matkul.semester;
            if (!groupedKrs.containsKey(semester)) {
              groupedKrs[semester] = [];
            }
            final krsWithSks = Krs(
              idKrs: krs.idKrs,
              idSkemaKrs: krs.idSkemaKrs,
              kodeMatakuliah: krs.kodeMatakuliah,
              namaMatakuliah: krs.namaMatakuliah,
              namaDosen: krs.namaDosen,
              sks: matkul.sks,  
            );
            groupedKrs[semester]!.add(krsWithSks);
          }
        }

        // Sort keys (semesters) in ascending order
        final sortedGroupedKrs = Map.fromEntries(
          groupedKrs.entries.toList()
            ..sort((e1, e2) => e1.key.compareTo(e2.key)),
        );

        emit(KrsLoaded(groupedKrs: sortedGroupedKrs));
      } catch (e) {
        emit(KrsError(message: e.toString()));
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

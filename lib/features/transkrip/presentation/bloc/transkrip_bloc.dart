import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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

  TranskripBloc({required GetTranskrip getTranskrip})
    : _getTranskrip = getTranskrip,
      super(TranskripInitial()) {
    on<GetListTranskrip>((event, emit) async {
      emit(TranskripLoading());
      try {
        final result = await _getTranskrip.execute(event.nim);
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
              String currentLetterGrade = 'N/A';
              totalSks += transkrip.sks;

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
                  // This is the calculation logic from the UI, now the single source of truth.
                  final double averageScore =
                      scores.reduce((a, b) => a + b) /
                      (nilai.project == 0 ? scores.length : 4);
                  currentLetterGrade = konversiNilaiKeHuruf(averageScore);

                  if (currentLetterGrade == 'A' ||
                      currentLetterGrade == 'B' ||
                      currentLetterGrade == 'C') {
                    passedCourses++;
                  } else {
                    failedCourses++;
                  }
                  totalBobot += _getBobot(currentLetterGrade) * transkrip.sks;
                }
              }
              // Add the enriched transkrip object (with letterGrade) to the new list
              enrichedTranskripList.add(
                transkrip.copyWith(letterGrade: currentLetterGrade),
              );
            }

            final double gpa = totalSks > 0 ? totalBobot / totalSks : 0;

            emit(
              TranskripLoaded(
                // Emit the new list with the calculated grades
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
      if (currentState is TranskripLoaded) {
        // All data is now taken directly from the state. No recalculations!
        emit(TranskripLoading());
        try {
          final AppLocalizations appLocalizations = event.appLocalizations;
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                return pw.Column(
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
                          pw.Text('${appLocalizations.nim}: 2244068'),
                          pw.Text('${appLocalizations.name}: Felix'),
                          pw.Text('${appLocalizations.roomClass}: Ti D 22'),
                          pw.Text(
                            '${appLocalizations.studyPrograms}: Teknik Informatika',
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
                      // The data is mapped directly from the state's listTranskrip
                      data: currentState.listTranskrip.map((t) {
                        return [
                          (currentState.listTranskrip.indexOf(t) + 1)
                              .toString(),
                          t.kodeMatkul,
                          t.matkul,
                          t.sks.toString(),
                          // The pre-calculated letterGrade is used here. No more calculation!
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
                          // Summary data is taken directly from the state
                          pw.Text(
                            '${appLocalizations.numberOfCoursesPassed}: ${currentState.passedCourses}',
                          ),
                          pw.Text(
                            '${appLocalizations.numberOfCoursesNotPassed}: ${currentState.failedCourses}',
                          ),
                          pw.Text(
                            '${appLocalizations.numberofCredits}: ${currentState.totalSks}',
                          ),
                          // GPA is formatted to 2 decimal places
                          pw.Text(
                            '${appLocalizations.gpa}: ${currentState.gpa.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
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

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';
import 'package:newsistime/features/transkrip/domain/function/grade_converter.dart';
import 'package:newsistime/features/transkrip/domain/usecases/get_transkrip.dart';
import 'package:newsistime/injection.dart';
import 'package:newsistime/l10n/app_localizations.dart';
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
          (failure) => emit(TranskripError(message: failure.message)),
          (data) => emit(TranskripLoaded(listTranskrip: data)),
        );
      } catch (e) {
        emit(TranskripError(message: e.toString()));
      }
    });

    on<DownloadTranskripPdf>((event, emit) async {
      if (state is TranskripLoaded) {
        emit(TranskripPdfLoading());
        try {
          final transkripData = (state as TranskripLoaded).listTranskrip;
          final AppLocalizations appLocalizations =
              myInjection<AppLocalizations>();
          final pdf = pw.Document();
          int passedCourses = 0;
          int failedCourses = 0;
          int totalSks = 0;
          double totalBobot = 0;
          String letterGrade = 'N/A';

          for (var transkrip in transkripData) {
            final nilai = transkrip.nilai;
            totalSks += transkrip.sks;
            if (nilai != null) {
              final List<double> scores = [
                nilai.tugas,
                nilai.uts,
                nilai.uas,
                nilai.absensi,
                nilai.project ?? 0,
                nilai.quiz ?? 0,
              ];
              if (scores.isNotEmpty) {
                final double averageScore =
                    scores.reduce((a, b) => a + b) /
                    (nilai.project == 0 ? scores.length : 4);
                final letterGrade = konversiNilaiKeHuruf(averageScore);
                if (letterGrade == 'A' ||
                    letterGrade == 'B' ||
                    letterGrade == 'C') {
                  passedCourses++;
                } else {
                  failedCourses++;
                }
                totalBobot += _getBobot(letterGrade) * transkrip.sks;
              }
            }
          }

          final double gpa = totalSks > 0 ? totalBobot / totalSks : 0;

          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Transkrip Nilai',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Container(
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
                        'No',
                        'Kode Matkul',
                        'Mata Kuliah',
                        'SKS',
                        'Nilai',
                      ],
                      data: transkripData
                          .map(
                            (t) => [
                              (transkripData.indexOf(t) + 1).toString(),
                              t.kodeMatkul,
                              t.matkul,
                              t.sks.toString(),
                              letterGrade,
                            ],
                          )
                          .toList(),
                    ),
                    pw.Container(
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
                            '${appLocalizations.numberOfCoursesPassed}: $passedCourses',
                          ),
                          pw.Text(
                            '${appLocalizations.numberOfCoursesNotPassed}: $failedCourses',
                          ),
                          pw.Text(
                            '${appLocalizations.numberofCredits}: $totalSks',
                          ),
                          pw.Text('${appLocalizations.gpa}: $gpa'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );

          final output = await getTemporaryDirectory();
          final file = File('${output.path}/transkrip.pdf');
          await file.writeAsBytes(await pdf.save());

          emit(TranskripPdfDownloaded(filePath: file.path));
        } catch (e) {
          emit(
            TranskripPdfError(
              message: 'Failed to generate PDF: ${e.toString()}',
            ),
          );
        }
      } else {
        emit(
          TranskripPdfError(
            message: 'Transkrip data not loaded. Please load transkrip first.',
          ),
        );
      }
    });
  }
}

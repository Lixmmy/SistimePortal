// import 'dart:io';

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsistime/core/helper/secure_storage.dart';
import 'package:newsistime/features/dosen/domain/usecases/get_dosen.dart';
import 'package:newsistime/features/krs/domain/entities/jadwal_krs.dart';
import 'package:newsistime/features/krs/domain/entities/krs.dart';
import 'package:newsistime/features/krs/domain/entities/tahun_ajaran.dart';
import 'package:newsistime/features/krs/domain/usecases/get_krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_mata_kuliah.dart';
import 'package:newsistime/features/krs/domain/usecases/get_skedul_krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_skema_krs.dart';
import 'package:newsistime/features/krs/domain/usecases/get_tahun_ajaran.dart';
import 'package:newsistime/features/krs/domain/usecases/post_krs.dart';
import 'package:newsistime/features/login/data/datasources/login_local_data_source.dart';
import 'package:newsistime/features/profil/data/datasources/local_datasource.dart';
import 'package:newsistime/core/localization/l10n/app_localizations.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'krs_event.dart';
part 'krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  final GetKrs getKrs;
  final GetMataKuliah getMataKuliah;
  final GetTahunAjaran getTahunAjaran;
  final GetSkemaKrs getSkemaKrs;
  final GetSkedulKrs getSkedulKrs;
  final GetDosen getDosen;
  final PostKrs postKrs;
  final ProfilLocalDataSource profilLocalDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  KrsBloc({
    required this.getKrs,
    required this.getTahunAjaran,
    required this.getSkemaKrs,
    required this.getSkedulKrs,
    required this.getMataKuliah,
    required this.getDosen,
    required this.postKrs,
    required this.profilLocalDataSource,
    required this.loginLocalDataSource,
  }) : super(KrsInitial()) {
    on<DownloadKrsPdf>((event, emit) async {
      final currentState = state;
      KrsLoadedMatakuliah? dataState;

      if (currentState is KrsLoadedMatakuliah) {
        dataState = currentState;
      }

      final profil = await profilLocalDataSource.getSavedProfilData();
      final username = await SecureStorage().getData('username');

      if (dataState != null && profil != null) {
        try {
          final AppLocalizations appLocalizations = event.appLocalizations;
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (pw.Context context) {
                final List<JadwalKrs> semesterData = [
                  ...dataState!.matakuliahWajib,
                  ...dataState.selectedMatakuliahPilihan,
                ];

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
                    krs.matkul.kodeMataKuliah,
                    krs.matkul.namaMataKuliah,
                    krs.dosen.namaDosen,
                    krs.matkul.sks.toString(),
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
                    pw.SizedBox(height: 10),
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
                                    alignment:
                                        row.indexOf(cell) == 4 ||
                                            row.indexOf(cell) == 0 ||
                                            row.indexOf(cell) == 1
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
          OpenFile.open(file.path);

          emit(KrsPdfDownloaded(filePath: file.path));
          emit(dataState);
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

    on<FetchTahunAjaranKrs>((event, emit) async {
      emit(KrsLoading());
      try {
        final tahunAjaranResult = await getTahunAjaran.execute();
        tahunAjaranResult.fold(
          (l) {
            emit(KrsError(message: l.message));
          },
          (r) {
            final listTahunAjaranAktif = r
                .where((tahun) => tahun.aktif)
                .toList();
            final listTahunAjaranTidakAktif = r
                .where((tahun) => !tahun.aktif)
                .toList();

            emit(
              KrsLoadedTahunAjaran(
                tahunAjaranAktif: listTahunAjaranAktif,
                tahunAjaranTidakAktif: listTahunAjaranTidakAktif,
              ),
            );
          },
        );
      } catch (e) {
        emit(KrsError(message: e.toString()));
      }
    });

    on<FetchMatakuliah>((event, emit) async {
      emit(KrsLoading());
      try {
        final listSkemaKrs = await getSkemaKrs.execute();
        final profil = await profilLocalDataSource.getSavedProfilData();

        await listSkemaKrs.fold(
          (skemaFailure) async {
            emit(KrsError(message: skemaFailure.message));
          },
          (skemaSuccess) async {
            final matchSkema = skemaSuccess.firstWhere(
              (s) => s.idTahunAjaran == event.idTahunAjaran,
              // &&
              // s.aktif == true &&
              // s.keterangan == '',
            );
            final idSkema = matchSkema.id.toString();
            final listSkedulKrs = await getSkedulKrs.execute(idSkema);
            await listSkedulKrs.fold(
              (skedulFailure) async {
                emit(KrsError(message: skedulFailure.message));
              },
              (skedulSuccess) async {
                final matkulList = await getMataKuliah.execute();
                await matkulList.fold(
                  (matkulFailure) async {
                    emit(KrsError(message: matkulFailure.message));
                  },
                  (matkulSuccess) async {
                    final matkulMap = {
                      for (var matkul in matkulSuccess)
                        matkul.id.toString(): matkul,
                    };
                    final dosenList = await getDosen.call();
                    await dosenList.fold(
                      (dosenFailure) async {
                        emit(KrsError(message: dosenFailure.message));
                      },
                      (dosenSuccess) async {
                        final dosenMap = {
                          for (var dosen in dosenSuccess)
                            dosen.id.toString(): dosen,
                        };
                        if (profil == null || profil.statusMahasiswa == null) {
                          emit(
                            const KrsError(
                              message:
                                  'Profile or Status Mahasiswa data is missing.',
                            ),
                          );
                          return;
                        }
                        final kodeKelasMahasiswa =
                            profil.statusMahasiswa!.kodeKelas;

                        int extractYear(String kodeKelas) {
                          String yearChar = kodeKelas.characters
                              .takeLast(2)
                              .toString();
                          return int.tryParse(yearChar) ?? 0;
                        }

                        int angkatanMahasiswa = extractYear(kodeKelasMahasiswa);
                        final userKrsList = await getKrs.execute(
                          profil.idUser.toString(),
                        );
                        await userKrsList.fold(
                          (userKrsFailure) async {
                            emit(KrsError(message: userKrsFailure.message));
                          },
                          (userKrsSuccess) async {
                            final userKrsSkedulIds = userKrsSuccess
                                .map((krs) => krs.idSkedul)
                                .toSet();

                            final skedulSuccessFiltered = skedulSuccess
                                .where(
                                  (skedul) =>
                                      userKrsSkedulIds.contains(skedul.id),
                                )
                                .toList();

                            if (skedulSuccessFiltered.isNotEmpty) {
                              final matakuliahFilled = skedulSuccessFiltered
                                  .map((skedul) {
                                    final matkul =
                                        matkulMap[skedul.idMataKuliah
                                            .toString()];
                                    final dosen =
                                        dosenMap[skedul.idDosen.toString()];

                                    if (matkul == null || dosen == null) {
                                      return null;
                                    }

                                    return JadwalKrs(
                                      matkul: matkul,
                                      dosen: dosen,
                                      tipeSkedul: 0,
                                      idSkedul: skedul.id,
                                      idUser: profil.idUser,
                                      keterangan: skedul.keterangan,
                                      kodeKelas: skedul.kodeKelas,
                                    );
                                  })
                                  .whereType<JadwalKrs>()
                                  .toList();

                              emit(
                                KrsLoadedMatakuliah(
                                  matakuliahWajib: matakuliahFilled,
                                  matakuliahPilihan: [],
                                  isAlreadyFilled: true,
                                ),
                              );
                            } else {
                              final skedulKrsFinal = skedulSuccess
                                  .where((skedul) {
                                    int tahunSkedul = extractYear(
                                      skedul.kodeKelas,
                                    );

                                    bool isWajib =
                                        skedul.kodeKelas == kodeKelasMahasiswa;
                                    bool isTambahan =
                                        skedul.kodeKelas !=
                                            kodeKelasMahasiswa &&
                                        tahunSkedul > angkatanMahasiswa;
                                    return isWajib || isTambahan;
                                  })
                                  .map((skedul) {
                                    final matkul =
                                        matkulMap[skedul.idMataKuliah
                                            .toString()];
                                    final dosen =
                                        dosenMap[skedul.idDosen.toString()];
                                    int tipeSkedul =
                                        (skedul.kodeKelas.toLowerCase() ==
                                            kodeKelasMahasiswa.toLowerCase())
                                        ? 0
                                        : 1;

                                    if (matkul == null || dosen == null) {
                                      return null;
                                    }

                                    return JadwalKrs(
                                      matkul: matkul,
                                      dosen: dosen,
                                      tipeSkedul: tipeSkedul,
                                      idSkedul: skedul.id,
                                      idUser: profil.idUser,
                                      keterangan: skedul.keterangan,
                                      kodeKelas: skedul.kodeKelas,
                                    );
                                  })
                                  .whereType<JadwalKrs>()
                                  .toList();
                              final matakuliahWajib = skedulKrsFinal
                                  .where((skedul) => skedul.tipeSkedul == 0)
                                  .toList();
                              final matakuliahPilihan = skedulKrsFinal
                                  .where((skedul) => skedul.tipeSkedul == 1)
                                  .toList();
                              emit(
                                KrsLoadedMatakuliah(
                                  matakuliahWajib: matakuliahWajib,
                                  matakuliahPilihan: matakuliahPilihan,
                                  isAlreadyFilled: false,
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      } catch (e) {
        emit(KrsError(message: e.toString()));
      }
    });

    on<ToggleMatakuliahSelection>((event, emit) {
      if (state is KrsLoadedMatakuliah) {
        final currentState = state as KrsLoadedMatakuliah;
        final updatedSelection = List<JadwalKrs>.from(
          currentState.selectedMatakuliahPilihan,
        );

        if (updatedSelection.contains(event.matakuliah)) {
          updatedSelection.remove(event.matakuliah);
        } else {
          updatedSelection.add(event.matakuliah);
        }

        emit(
          KrsLoadedMatakuliah(
            matakuliahWajib: currentState.matakuliahWajib,
            matakuliahPilihan: currentState.matakuliahPilihan,
            selectedMatakuliahPilihan: updatedSelection,
            isAlreadyFilled: currentState.isAlreadyFilled,
          ),
        );
      }
    });

    on<PostKrsEvent>((event, emit) async {
      if (state is KrsLoadedMatakuliah) {
        final currentState = state as KrsLoadedMatakuliah;
        final matakuliahWajib = currentState.matakuliahWajib;
        final selectedMatakuliahPilihan =
            currentState.selectedMatakuliahPilihan;
        final profil = await profilLocalDataSource.getSavedProfilData();
        if (profil == null) {
          emit(
            const KrsError(
              message: 'Profile data is missing. Cannot post KRS.',
            ),
          );
          return;
        }
        final List<JadwalKrs> allSelectedMatakuliah = [
          ...matakuliahWajib,
          ...selectedMatakuliahPilihan,
        ];

        final listKrs = allSelectedMatakuliah.map((jadwal) {
          return Krs(
            id: jadwal.matkul.id,
            idUser: jadwal.idUser,
            idSkedul: jadwal.idSkedul,
            tipeSkedul: jadwal.tipeSkedul,
            keterangan: jadwal.keterangan,
          );
        }).toList();
        try {
          final postResult = await postKrs.call(
            id: profil.idUser.toString(),
            krs: listKrs,
          );
          postResult.fold(
            (failure) {
              emit(KrsError(message: failure.message));
            },
            (success) {
              emit(const KrsPostSuccess(message: "KRS berhasil dikirim"));
            },
          );
        } catch (e) {
          emit(KrsError(message: e.toString()));
        }
      }
    });
  }
}

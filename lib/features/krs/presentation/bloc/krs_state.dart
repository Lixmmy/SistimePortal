part of 'krs_bloc.dart';

abstract class KrsState extends Equatable {
  const KrsState();

  @override
  List<Object> get props => [];
}

class KrsInitial extends KrsState {}

class KrsLoading extends KrsState {}

class KrsError extends KrsState {
  final String message;

  const KrsError({required this.message});

  @override
  List<Object> get props => [message];
}

class KrsPdfDownloaded extends KrsState {
  final String filePath;

  const KrsPdfDownloaded({required this.filePath});
  @override
  List<Object> get props => [filePath];
}

class KrsTokenExpired extends KrsState {
  final String message;

  const KrsTokenExpired({required this.message});

  @override
  List<Object> get props => [message];
}

class KrsLoadedTahunAjaran extends KrsState {
  final List<TahunAjaran> tahunAjaranAktif;
  final List<TahunAjaran> tahunAjaranTidakAktif;
  const KrsLoadedTahunAjaran({
    required this.tahunAjaranAktif,
    required this.tahunAjaranTidakAktif,
  });

  @override
  List<Object> get props => [tahunAjaranAktif, tahunAjaranTidakAktif];
}

class KrsLoadedMatakuliah extends KrsState {
  final List<JadwalKrs> matakuliahWajib;
  final List<JadwalKrs> matakuliahPilihan;
  final List<JadwalKrs> selectedMatakuliahPilihan;
  final bool isAlreadyFilled;

  const KrsLoadedMatakuliah({
    required this.matakuliahWajib,
    required this.matakuliahPilihan,
    this.selectedMatakuliahPilihan = const [],
    this.isAlreadyFilled = false,
  });

  @override
  List<Object> get props => [
    matakuliahWajib,
    matakuliahPilihan,
    selectedMatakuliahPilihan,
    isAlreadyFilled,
  ];
}

class KrsPostSuccess extends KrsState {
  final String message;

  const KrsPostSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

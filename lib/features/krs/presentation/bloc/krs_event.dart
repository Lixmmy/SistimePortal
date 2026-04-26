part of 'krs_bloc.dart';

abstract class KrsEvent extends Equatable {
  const KrsEvent();

  @override
  List<Object> get props => [];
}

// class FetchKrsData extends KrsEvent {}

// class DownloadKrsPdf extends KrsEvent {
//   final AppLocalizations appLocalizations;
//   final int semester;

//   const DownloadKrsPdf({
//     required this.appLocalizations,
//     required this.semester,
//   });

//   @override
//   List<Object> get props => [appLocalizations, semester];
// }

class FetchMatakuliah extends KrsEvent {
  final int idTahunAjaran;

  const FetchMatakuliah({required this.idTahunAjaran});

  @override
  List<Object> get props => [idTahunAjaran];
}

class FetchTahunAjaranKrs extends KrsEvent {}

class ToggleMatakuliahSelection extends KrsEvent {
  final JadwalKrs matakuliah;

  const ToggleMatakuliahSelection({required this.matakuliah});

  @override
  List<Object> get props => [matakuliah];
}

final class PostKrsEvent extends KrsEvent {}

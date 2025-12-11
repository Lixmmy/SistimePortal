part of 'krs_bloc.dart';

abstract class KrsEvent extends Equatable {
  const KrsEvent();

  @override
  List<Object> get props => [];
}

class FetchKrsData extends KrsEvent {}

class DownloadKrsPdf extends KrsEvent {
  final AppLocalizations appLocalizations;
  final int semester;

  const DownloadKrsPdf({
    required this.appLocalizations,
    required this.semester,
  });

  @override
  List<Object> get props => [appLocalizations, semester];
}

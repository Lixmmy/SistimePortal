part of 'transkrip_bloc.dart';

abstract class TranskripEvent extends Equatable {
  const TranskripEvent();

  @override
  List<Object> get props => [];
}

class GetListTranskrip extends TranskripEvent {}

class DownloadTranskripPdf extends TranskripEvent {
  final AppLocalizations appLocalizations;
  const DownloadTranskripPdf(this.appLocalizations);
  @override
  List<Object> get props => [appLocalizations];
}

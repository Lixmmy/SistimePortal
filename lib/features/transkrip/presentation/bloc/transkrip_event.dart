part of 'transkrip_bloc.dart';


abstract class TranskripEvent extends Equatable {
  const TranskripEvent();

  @override
  List<Object> get props => [];
}

class GetListTranskrip extends TranskripEvent {
  final String nim;
  const GetListTranskrip(this.nim);
  @override
  List<Object> get props => [nim];
}

class DownloadTranskripPdf extends TranskripEvent {
  final AppLocalizations appLocalizations;
  const DownloadTranskripPdf(this.appLocalizations);
  @override
  List<Object> get props => [appLocalizations];
}
part of 'khs_bloc.dart';

abstract class KhsEvent extends Equatable {
  const KhsEvent();

  @override
  List<Object> get props => [];
}

class FetchKhsData extends KhsEvent {}

class DownloadKhsPdf extends KhsEvent {
  final AppLocalizations appLocalizations;
  final int semester;
  const DownloadKhsPdf({
    required this.appLocalizations,
    required this.semester,
  });

  @override
  List<Object> get props => [appLocalizations, semester];
}

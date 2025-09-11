part of 'transkrip_bloc.dart';

abstract class TranskripState extends Equatable {
  const TranskripState();  

  @override
  List<Object?> get props => [];
}
class TranskripInitial extends TranskripState {}

final class TranskripLoading extends TranskripState {}

final class TranskripLoaded extends TranskripState {
  final List<Transkrip> listTranskrip ;

  const TranskripLoaded({required this.listTranskrip});

  @override
  List<Object?> get props => [listTranskrip];
}

final class TranskripError extends TranskripState {
  final String message;

  const TranskripError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TranskripPdfLoading extends TranskripState {}

final class TranskripPdfDownloaded extends TranskripState {
  final String filePath;

  const TranskripPdfDownloaded({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

final class TranskripPdfError extends TranskripState {
  final String message;

  const TranskripPdfError({required this.message});

  @override
  List<Object?> get props => [message];
}
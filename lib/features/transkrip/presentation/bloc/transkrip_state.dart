part of 'transkrip_bloc.dart';

abstract class TranskripState extends Equatable {
  const TranskripState();

  @override
  List<Object?> get props => [];
}

class TranskripInitial extends TranskripState {}

final class TranskripLoading extends TranskripState {}

final class TranskripLoaded extends TranskripState {
  final List<Transkrip> listTranskrip;
  final int passedCourses;
  final int failedCourses;
  final int totalSks;
  final double gpa;

  const TranskripLoaded({
    required this.listTranskrip,
    this.passedCourses = 0,
    this.failedCourses = 0,
    this.totalSks = 0,
    this.gpa = 0,
  });

  @override
  List<Object?> get props => [listTranskrip];
}

final class TranskripError extends TranskripState {
  final String message;

  const TranskripError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TranskripPdfDownloaded extends TranskripState {
  final String filePath;

  const TranskripPdfDownloaded({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

part of 'khs_bloc.dart';

abstract class KhsState extends Equatable {
  const KhsState();

  @override
  List<Object> get props => [];
}

class KhsInitial extends KhsState {}

class KhsLoading extends KhsState {}

class KhsLoaded extends KhsState {
  final Map<int, List<Khs>> groupedKhs;

  const KhsLoaded({required this.groupedKhs});

  @override
  List<Object> get props => [groupedKhs];
}

class KhsError extends KhsState {
  final String message;

  const KhsError({required this.message});

  @override
  List<Object> get props => [message];
}

class KhsPdfDownloaded extends KhsState {
  final String filePath;

  const KhsPdfDownloaded({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

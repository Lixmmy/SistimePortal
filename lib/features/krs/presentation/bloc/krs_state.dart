part of 'krs_bloc.dart';

abstract class KrsState extends Equatable {
  const KrsState();

  @override
  List<Object> get props => [];
}

class KrsInitial extends KrsState {}

class KrsLoading extends KrsState {}

class KrsLoaded extends KrsState {
  final Map<int, List<Krs>> groupedKrs;

  const KrsLoaded({required this.groupedKrs});

  @override
  List<Object> get props => [groupedKrs];
}

class KrsError extends KrsState {
  final String message;

  const KrsError({required this.message});

  @override
  List<Object> get props => [message];
}

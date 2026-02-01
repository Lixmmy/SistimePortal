part of 'agama_bloc.dart';

abstract class AgamaState extends Equatable {
  const AgamaState();

  @override
  List<Object> get props => [];
}

class AgamaInitial extends AgamaState {}

class AgamaLoading extends AgamaState {}

class AgamaLoaded extends AgamaState {
  final List<Agama> agamaList;

  const AgamaLoaded(this.agamaList);

  @override
  List<Object> get props => [agamaList];
}

class AgamaError extends AgamaState {
  final String message;

  const AgamaError(this.message);

  @override
  List<Object> get props => [message];
}

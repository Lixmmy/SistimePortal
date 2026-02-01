part of 'agama_bloc.dart';

abstract class AgamaEvent extends Equatable {
  const AgamaEvent();

  @override
  List<Object> get props => [];
}

class FetchAgamaList extends AgamaEvent {}

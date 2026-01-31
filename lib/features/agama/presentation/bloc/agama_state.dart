part of 'agama_bloc.dart';

abstract class AgamaState extends Equatable {
  const AgamaState();  

  @override
  List<Object> get props => [];
}
class AgamaInitial extends AgamaState {}

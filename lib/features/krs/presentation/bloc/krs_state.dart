part of 'krs_bloc.dart';

abstract class KrsState extends Equatable {
  const KrsState();  

  @override
  List<Object> get props => [];
}
class KrsInitial extends KrsState {}

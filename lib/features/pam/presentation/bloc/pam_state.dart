part of 'pam_bloc.dart';

abstract class PamState extends Equatable {
  const PamState();  

  @override
  List<Object> get props => [];
}
class PamInitial extends PamState {}

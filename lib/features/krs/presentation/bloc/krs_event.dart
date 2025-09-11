part of 'krs_bloc.dart';

abstract class KrsEvent extends Equatable {
  const KrsEvent();

  @override
  List<Object> get props => [];
}

class FetchKrsData extends KrsEvent {
  final String nim;

  const FetchKrsData({required this.nim});

  @override
  List<Object> get props => [nim];
}

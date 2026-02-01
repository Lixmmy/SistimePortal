part of 'waktu_kuliah_bloc.dart';

abstract class WaktuKuliahEvent extends Equatable {
  const WaktuKuliahEvent();

  @override
  List<Object> get props => [];
}

class FetchWaktuKuliahList extends WaktuKuliahEvent {}

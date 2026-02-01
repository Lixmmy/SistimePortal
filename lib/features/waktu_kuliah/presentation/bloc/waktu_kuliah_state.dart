part of 'waktu_kuliah_bloc.dart';

abstract class WaktuKuliahState extends Equatable {
  const WaktuKuliahState();

  @override
  List<Object> get props => [];
}

class WaktuKuliahInitial extends WaktuKuliahState {}

class WaktuKuliahLoading extends WaktuKuliahState {}

class WaktuKuliahLoaded extends WaktuKuliahState {
  final List<WaktuKuliah> waktuKuliahList;

  const WaktuKuliahLoaded(this.waktuKuliahList);

  @override
  List<Object> get props => [waktuKuliahList];
}

class WaktuKuliahError extends WaktuKuliahState {
  final String message;

  const WaktuKuliahError(this.message);

  @override
  List<Object> get props => [message];
}

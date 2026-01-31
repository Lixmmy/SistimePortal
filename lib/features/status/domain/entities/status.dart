import 'package:equatable/equatable.dart';

class Status extends Equatable {
  final int idStatus;
  final String status;

  const Status({required this.idStatus, required this.status});

  @override
  List<Object?> get props => [idStatus, status];
}

import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String token;
  final String? message;
  final int? status;

  const Token({required this.token, this.message, this.status});

  @override
  List<Object?> get props => [token, message, status];
}

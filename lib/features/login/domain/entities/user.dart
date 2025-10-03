import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String nim;
  final String password;

  const User({required this.nim, required this.password});

  @override
  List<Object?> get props => [nim, password];
}

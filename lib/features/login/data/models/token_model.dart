import 'package:newsistime/features/login/domain/entities/token.dart';

class TokenModel {
  final String token;
  final String? message;
  final int? status;

  const TokenModel({required this.token, this.message, this.status});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'message': message, 'status': status};
  }

  Token toEntity() {
    return Token(token: token, message: message, status: status);
  }
}

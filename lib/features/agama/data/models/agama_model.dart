import 'package:newsistime/features/agama/domain/entities/agama.dart';

class AgamaModel {
  final String id;
  final String name;

  AgamaModel({required this.id, required this.name});

  factory AgamaModel.fromJson(Map<String, dynamic> json) {
    return AgamaModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Agama toEntity() {
    return Agama(id: id, name: name);
  }
}
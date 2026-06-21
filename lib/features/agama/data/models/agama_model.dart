import 'package:sistime_portal/features/agama/domain/entities/agama.dart';

class AgamaModel {
  final String id;
  final String name;

  AgamaModel({required this.id, required this.name});

  factory AgamaModel.fromJson(Map<String, dynamic> json) {
    return AgamaModel(
      id: json['idAgama'] as String,
      name: json['agama'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'idAgama': id, 'agama': name};
  }

  Agama toEntity() {
    return Agama(id: id, name: name);
  }
}

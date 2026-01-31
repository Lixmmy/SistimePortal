import 'package:newsistime/features/status/domain/entities/status.dart';

class StatusModel {
  final int idStatus;
  final String status;

  const StatusModel({required this.idStatus, required this.status});
  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      StatusModel(idStatus: json["idStatus"], status: json["status"]);
  Map<String, dynamic> toJson() => {"idStatus": idStatus, "status": status};

  Status toEntity() => Status(idStatus: idStatus, status: status);
}

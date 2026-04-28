import 'package:newsistime/features/krs/domain/entities/krs.dart';

class KrsModel {
  final int idModel;
  final int idUsersModel;
  final int idSkedulModel;
  final int tipeSkedul;
  final String? keterangan;

  KrsModel({
    required this.idModel,
    required this.idUsersModel,
    required this.idSkedulModel,
    required this.tipeSkedul,
    this.keterangan,
  });

  factory KrsModel.fromJson(Map<String, dynamic> json) {
    return KrsModel(
      idModel: json['id'],
      idUsersModel: json['idUser'],
      idSkedulModel: json['idSkedul'],
      tipeSkedul: json['tipeSkedul'],
      keterangan: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idModel,
      'idUsers': idUsersModel,
      'idSkedul': idSkedulModel,
      'tipeSkedul': tipeSkedul,
      'keterangan': keterangan,
    };
  }

  Krs toEntity() {
    return Krs(
      id: idModel,
      idUser: idUsersModel,
      idSkedul: idSkedulModel,
      tipeSkedul: tipeSkedul,
      keterangan: keterangan, // Default value, will be updated in BLoC
    );
  }
}

import 'package:sistime_portal/features/dosen/domain/entities/dosen.dart';

class DosenModel {
  final int id;
  final String namaDosen;
  final String? statusDosen;
  final String? email;
  final String? noTelepon;
  final String? alamat;
  final String? keterangan;

  DosenModel({
    required this.id,
    required this.namaDosen,
    this.statusDosen,
    this.email,
    this.noTelepon,
    this.alamat,
    this.keterangan,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      id: json['id'],
      namaDosen: json['namaDosen'],
      statusDosen: json['statusDosen'],
      email: json['email'],
      noTelepon: json['noTelepon'],
      alamat: json['alamat'],
      keterangan: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaDosen': namaDosen,
      'statusDosen': statusDosen,
      'email': email,
      'noTelepon': noTelepon,
      'alamat': alamat,
      'keterangan': keterangan,
    };
  }

  Dosen toEntity() {
    return Dosen(
      id: id.toString(),
      namaDosen: namaDosen,
      statusDosen: statusDosen,
      emailDosen: email,
      noTelpDosen: noTelepon,
      alamat: alamat,
      keterangan: keterangan,
    );
  }
}

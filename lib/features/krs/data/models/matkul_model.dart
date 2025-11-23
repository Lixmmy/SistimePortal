// import 'package:newsistime/features/krs/domain/entities/matkul.dart';

// class MatkulModel {
//   final int id;
//   final String kodeMataKuliahModel;
//   final String namaMataKuliahModel;
//   final String tipeMatakuliahModel;
//   final String? keteranganModel;
//   final int sksModel;
//   final int semesterModel;

//   const MatkulModel({
//     required this.id,
//     required this.tipeMatakuliahModel,
//     required this.kodeMataKuliahModel,
//     required this.namaMataKuliahModel,
//     this.keteranganModel,
//     required this.sksModel,
//     required this.semesterModel,
//   });

//   factory MatkulModel.fromJson(Map<String, dynamic> json) {
//     return MatkulModel(
//       id: json['id'],
//       tipeMatakuliahModel: json['tipeMataKuliah'],
//       kodeMataKuliahModel: json['kodeMatakuliah'],
//       namaMataKuliahModel: json['namaMatakuliah'],
//       keteranganModel: json['keterangan'],
//       sksModel: json['sks'],
//       semesterModel: json['semester'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'idTipematakuliah': tipeMatakuliahModel,
//       'kodeMatakuliah': kodeMataKuliahModel,
//       'namaMatakuliah': namaMataKuliahModel,
//       'keterangan': keteranganModel,
//       'sks': sksModel,
//       'semester': semesterModel,
//     };
//   }

//   Matkul toEntity() {
//     return Matkul(
//       id: id,
//       tipeMataKuliah: tipeMatakuliahModel,
//       kodeMataKuliah: kodeMataKuliahModel,
//       namaMataKuliah: namaMataKuliahModel,
//       keterangan: keteranganModel,
//       sks: sksModel,
//       semester: semesterModel,
//     );
//   }
// }

// class ListMatkulModel {
//   final List<MatkulModel> listMatkulModel;

//   const ListMatkulModel({required this.listMatkulModel});

//   factory ListMatkulModel.fromJson(List<dynamic> json) {
//     return ListMatkulModel(
//       listMatkulModel: json.map((e) => MatkulModel.fromJson(e)).toList(),
//     );
//   }

//   ListMatkul toEntity() {
//     return ListMatkul(
//       matkul: listMatkulModel.map((e) {
//         return e.toEntity();
//       }).toList(),
//     );
//   }
// }

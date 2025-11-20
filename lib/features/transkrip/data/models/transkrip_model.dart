import 'package:newsistime/features/transkrip/data/models/nilai_model.dart';
import 'package:newsistime/features/transkrip/domain/entities/transkrip.dart';

class TranskripModel {
  final int krsIdModel;
  final String kodeMatkulModel;
  final String matkulModel;
  final int sksModel;
  final NilaiModel? nilaiModel;

  const TranskripModel({
    required this.krsIdModel,
    required this.kodeMatkulModel,
    required this.matkulModel,
    required this.sksModel,
    this.nilaiModel,
  });

  factory TranskripModel.fromJson(Map<String, dynamic> json) {
    return TranskripModel(
      krsIdModel: json['krsId'],
      kodeMatkulModel: json['kodeMatkul'],
      matkulModel: json['matkul'],
      sksModel: json['sks'],
      nilaiModel: json['nilais'] != null
          ? NilaiModel.fromJson(json['nilais'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['krsId'] = krsIdModel;
    data['kodeMatkul'] = kodeMatkulModel;
    data['matkul'] = matkulModel;
    data['sks'] = sksModel;
    if (nilaiModel != null) {
      data['nilais'] = nilaiModel!.toJson();
    }
    return data;
  }

  Transkrip toEntity() {
    return Transkrip(
      krsId: krsIdModel,
      kodeMatkul: kodeMatkulModel,
      matkul: matkulModel,
      sks: sksModel,
      nilai: nilaiModel?.toEntity(),
    );
  }
}

class ListTranskripModel {
  final List<TranskripModel> listTranskripModel;
  const ListTranskripModel({required this.listTranskripModel});

  factory ListTranskripModel.fromJson(List<dynamic> json) {
    return ListTranskripModel(
      listTranskripModel: json.map((e) => TranskripModel.fromJson(e)).toList(),
    );
  }

  ListTranskrip toEntity() {
    return ListTranskrip(
      transkrip: listTranskripModel.map((e) => e.toEntity()).toList(),
    );
  }
}


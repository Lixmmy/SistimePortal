import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsistime/core/theme/theme.dart';

String konversiNilaiKeHuruf(double nilaiAkhir) {
  if (nilaiAkhir >= 90) {
    return 'A';
  } else if (nilaiAkhir >= 80) {
    return 'B';
  } else if (nilaiAkhir >= 70) {
    return 'C';
  } else if (nilaiAkhir >= 60) {
    return 'D';
  } else {
    return 'E';
  }
}

double getBobot(String letterGrade) {
  switch (letterGrade) {
    case 'A':
      return 4.0;
    case 'B':
      return 3.0;
    case 'C':
      return 2.0;
    case 'D':
      return 1.0;
    default:
      return 0.0;
  }
}

Color getGradeColor(String letterGrade) {
  switch (letterGrade) {
    case 'A':
      return Colors.green;
    case 'B':
      return AppTheme.primaryColorA0;
    case 'C':
      return Colors.yellow;
    case 'D':
      return Colors.orange;
    default:
      return Colors.red;
  }
}

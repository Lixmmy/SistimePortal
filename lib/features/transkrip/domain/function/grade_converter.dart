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

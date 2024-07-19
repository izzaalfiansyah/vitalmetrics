import 'dart:math';

double getBMI({
  required double tinggi,
  required double berat,
  required double umur,
}) {
  double bmi = berat / pow(tinggi / 100, 2);

  if (umur > 18) {
    bmi = bmi;
  } else if (umur >= 5) {
    bmi = bmi / 4;
  } else {
    bmi = bmi;
  }

  return bmi;
}

double getLemakTubuh({
  required String jenisKelamin,
  required double bmi,
  required double umur,
}) {
  double lemak;

  if (jenisKelamin == "l") {
    lemak = (1.2 * bmi) + (0.23 * umur) - 10.8 - 5.4;
  } else {
    lemak = (1.2 * bmi) + (0.23 * umur) - 5.4;
  }

  return lemak;
}

int getUmur(String date) {
  DateTime tanggalLahir = DateTime.parse(date);
  DateTime tanggalSekarang = DateTime.now();

  int age = tanggalSekarang.year - tanggalLahir.year;
  if (tanggalSekarang.month < tanggalLahir.month ||
      (tanggalSekarang.month == tanggalLahir.month &&
          tanggalSekarang.day < tanggalLahir.day)) {
    age--;
  }
  return age;
}

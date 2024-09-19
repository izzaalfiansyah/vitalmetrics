import 'package:vitalmetrics/models/sd.dart';

class Pengukuran {
  dynamic id;
  dynamic userId;
  int userUmur;
  int userBulan;
  int userUmurBulan;
  dynamic perangkatId;
  double tinggi;
  double berat;
  double bmi;
  double lemakTubuh;
  double airDalamTubuh;
  double massaOtotTubuh;
  double massaTulang;
  double massaTulangPersentase;
  double massaProtein;
  double massaProteinPersentase;
  double beratBadanIdeal;
  double skorBadan;
  SD? sd;
  SD? zScore;
  SG? statusGizi;
  String createdAt;

  Pengukuran({
    this.id = '',
    this.userId = '',
    this.userUmur = 0,
    this.userBulan = 0,
    this.userUmurBulan = 0,
    this.perangkatId = '',
    this.tinggi = 0,
    this.berat = 0,
    this.bmi = 0,
    this.lemakTubuh = 0,
    this.airDalamTubuh = 0,
    this.massaOtotTubuh = 0,
    this.massaTulang = 0,
    this.massaTulangPersentase = 0,
    this.massaProtein = 0,
    this.massaProteinPersentase = 0,
    this.beratBadanIdeal = 0,
    this.skorBadan = 0,
    this.createdAt = '',
    this.sd,
    this.zScore,
    this.statusGizi,
  });

  factory Pengukuran.fromJson(Map<String, dynamic> map) {
    return Pengukuran(
      id: map['id'] ?? '',
      userId: map['user_id'],
      userUmur: map['user_umur'],
      userBulan: map['user_bulan'],
      userUmurBulan: map['user_umur_bulan'],
      perangkatId: map['perangkat_id'],
      tinggi: map['tinggi'].toDouble(),
      berat: map['berat'].toDouble(),
      bmi: map['bmi'].toDouble(),
      lemakTubuh: map['lemak_tubuh'].toDouble(),
      airDalamTubuh: map['air_dalam_tubuh'].toDouble(),
      massaOtotTubuh: map['massa_otot_tubuh'].toDouble(),
      massaTulang: map['massa_tulang'].toDouble(),
      massaTulangPersentase: map['massa_tulang_persentase'].toDouble(),
      massaProtein: map['massa_protein'].toDouble(),
      massaProteinPersentase: map['massa_protein_persentase'].toDouble(),
      beratBadanIdeal: map['berat_badan_ideal'].toDouble(),
      skorBadan: map['skor_badan'].toDouble(),
      sd: SD(
        bbPerU: map['sd']['bb_per_u'],
        tbPerU: map['sd']['tb_per_u'],
        bbPerTB: map['sd']['bb_per_tb'],
        imtPerU: map['sd']['imt_per_u'],
      ),
      zScore: SD(
        bbPerU: map['z_score']['bb_per_u'],
        tbPerU: map['z_score']['tb_per_u'],
        bbPerTB: map['z_score']['bb_per_tb'],
        imtPerU: map['z_score']['imt_per_u'],
      ),
      statusGizi: SG(
        bbPerU: map['status_gizi']?['bb_per_u'],
        tbPerU: map['status_gizi']?['tb_per_u'],
        bbPerTB: map['status_gizi']?['bb_per_tb'],
        imtPerU: map['status_gizi']?['imt_per_u'],
        imt: map['status_gizi']?['imt'],
      ),
      createdAt: map['created_at'] ?? map['time'],
    );
  }

  toJSON() {
    return {
      'user_id': userId,
      'user_umur': userUmur,
      'perangkat_id': perangkatId,
      'tinggi': tinggi,
      'berat': berat,
    };
  }
}

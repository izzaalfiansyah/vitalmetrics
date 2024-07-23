class Pengukuran {
  dynamic id;
  dynamic userId;
  int userUmur;
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
  String createdAt;

  Pengukuran({
    this.id = '',
    this.userId = '',
    this.userUmur = 0,
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
    this.createdAt = '',
  });

  factory Pengukuran.fromJson(Map<String, dynamic> map) {
    return Pengukuran(
      id: map['id'],
      userId: map['user_id'],
      userUmur: map['user_umur'],
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
      createdAt: map['created_at'],
    );
  }

  toJSON() {
    return {
      'user_id': userId,
      'user_umur': userUmur,
      'perangkat_id': perangkatId,
      'tinggi': tinggi,
      'berat': berat,
      'created_at': createdAt,
    };
  }
}

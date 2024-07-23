class Pengukuran {
  dynamic id;
  dynamic userId;
  int userUmur;
  dynamic perangkatId;
  double tinggi;
  double berat;
  double bmi;
  double lemakTubuh;
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

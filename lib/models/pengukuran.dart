class Pengukuran {
  String id;
  String userId;
  int userUmur;
  String perangkatId;
  double tinggi;
  double berat;
  String createdAt;

  Pengukuran({
    this.id = '',
    this.userId = '',
    this.userUmur = 0,
    this.perangkatId = '',
    this.tinggi = 0,
    this.berat = 0,
    this.createdAt = '',
  });

  factory Pengukuran.fromJson(Map<String, dynamic> map) {
    return Pengukuran(
      id: map['id'],
      userId: map['user_id'],
      userUmur: num.parse(map['user_umur']).toInt(),
      perangkatId: map['perangkat_id'],
      tinggi: num.parse(map['tinggi']).toDouble(),
      berat: num.parse(map['berat']).toDouble(),
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

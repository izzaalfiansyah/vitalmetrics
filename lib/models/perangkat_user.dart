class PerangkatUser {
  dynamic id;
  String nomorSerial;
  String? nomorSerialTinggi;
  dynamic userId;
  num kalibrasiTinggi = 0;
  bool kalibrasiTinggiOn = false;
  num kalibrasiBerat = 0;
  bool kalibrasiBeratOn = false;

  PerangkatUser({
    this.id = '',
    this.nomorSerial = '',
    this.userId = '',
    this.nomorSerialTinggi,
    this.kalibrasiTinggi = 0,
    this.kalibrasiTinggiOn = false,
    this.kalibrasiBerat = 0,
    this.kalibrasiBeratOn = false,
  });

  factory PerangkatUser.fromJson(Map<String, dynamic> map) {
    return PerangkatUser(
      id: map['id'],
      nomorSerial: map['nomor_serial'],
      nomorSerialTinggi: map['nomor_serial_tinggi'],
      userId: map['user_id'],
      kalibrasiTinggi: map['kalibrasi_tinggi'],
      kalibrasiTinggiOn: map['kalibrasi_tinggi_on'],
      kalibrasiBerat: map['kalibrasi_berat'],
      kalibrasiBeratOn: map['kalibrasi_berat_on'],
    );
  }

  toJson() {
    return {
      'nomor_serial': nomorSerial,
      'nomor_serial_tinggi': nomorSerialTinggi,
      'user_id': userId,
    };
  }
}

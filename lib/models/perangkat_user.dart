class PerangkatUser {
  dynamic id;
  String nomorSerial;
  String? nomorSerialTinggi;
  dynamic userId;

  PerangkatUser({
    this.id = '',
    this.nomorSerial = '',
    this.userId = '',
    this.nomorSerialTinggi,
  });

  factory PerangkatUser.fromJson(Map<String, dynamic> map) {
    return PerangkatUser(
      id: map['id'],
      nomorSerial: map['nomor_serial'],
      nomorSerialTinggi: map['nomor_serial_tinggi'],
      userId: map['user_id'],
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

class PerangkatUser {
  String id;
  String nomorSerial;
  String userId;

  PerangkatUser({
    required this.id,
    required this.nomorSerial,
    required this.userId,
  });

  factory PerangkatUser.fromJson(Map<String, dynamic> map) {
    return PerangkatUser(
      id: map['id'],
      nomorSerial: map['nomor_serial'],
      userId: map['user_id'],
    );
  }

  toJson() {
    return {
      'nomor_serial': nomorSerial,
      'user_id': userId,
    };
  }
}

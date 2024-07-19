class UserPerangkat {
  String id;
  String nomorSerial;
  String userId;

  UserPerangkat({
    required this.id,
    required this.nomorSerial,
    required this.userId,
  });

  factory UserPerangkat.fromJson(Map<String, dynamic> map) {
    return UserPerangkat(
      id: map['id'],
      nomorSerial: map['nomor_serial'],
      userId: map['user_id'],
    );
  }

  toJson() {
    return {
      'id': id,
      'nomor_serial': nomorSerial,
      'user_id': userId,
    };
  }
}

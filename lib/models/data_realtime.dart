class DataRealtime {
  final double tinggi;
  final double berat;
  final String createdAt;
  final dynamic perangkatId;

  DataRealtime({
    this.tinggi = 0,
    this.berat = 0,
    this.createdAt = '',
    this.perangkatId = '',
  });

  factory DataRealtime.fromJson(Map<String, dynamic> map) {
    return DataRealtime(
      tinggi: map['tinggi'].toDouble(),
      berat: map['berat'].toDouble(),
      createdAt: map['created_at'],
      perangkatId: map['perangkat_id'],
    );
  }

  toJson() {
    return {
      'tinggi': tinggi,
      'berat': berat,
      'created_at': createdAt,
      'perangkat_id': perangkatId,
    };
  }
}

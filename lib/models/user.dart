class User {
  String id;
  String username;
  String email;
  String nama;
  String tanggalLahir;
  String jenisKelamin;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.nama,
    required this.tanggalLahir,
    required this.jenisKelamin,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      nama: map['nama'],
      tanggalLahir: map['tanggal_lahir'],
      jenisKelamin: map['jenis_kelamin'],
    );
  }

  toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'nama': nama,
      'tanggalLahir': tanggalLahir,
      'jenisKelamin': jenisKelamin,
    };
  }
}

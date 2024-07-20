class User {
  String id;
  String username;
  String password;
  String email;
  String nama;
  String tanggalLahir;
  String jenisKelamin;

  User({
    this.id = '',
    this.username = '',
    this.password = '',
    this.email = '',
    this.nama = '',
    this.tanggalLahir = '',
    this.jenisKelamin = '',
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
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
      'password': password,
      'email': email,
      'nama': nama,
      'tanggal_lahir': tanggalLahir,
      'jenis_kelamin': jenisKelamin,
    };
  }
}

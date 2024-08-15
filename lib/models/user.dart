class User {
  dynamic id;
  String username;
  String password;
  String passwordConfirmation;
  String email;
  String nama;
  String tanggalLahir;
  String jenisKelamin;
  String role;
  int umur;

  User({
    this.id = '',
    this.username = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.email = '',
    this.nama = '',
    this.tanggalLahir = '',
    this.jenisKelamin = '',
    this.umur = 0,
    this.role = '',
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      nama: map['nama'],
      tanggalLahir: map['tanggal_lahir'],
      jenisKelamin: map['jenis_kelamin'],
      umur: map['umur'],
      role: map['role'],
    );
  }

  toJson() {
    return {
      'username': username,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'email': email,
      'nama': nama,
      'tanggal_lahir': tanggalLahir,
      'jenis_kelamin': jenisKelamin,
      'role': role,
    };
  }
}

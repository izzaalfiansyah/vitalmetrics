import 'package:vitalmetrics/libs/rumus.dart';

class User {
  dynamic id;
  String username;
  String password;
  String email;
  String nama;
  String tanggalLahir;
  String jenisKelamin;
  int umur;

  User({
    this.id = '',
    this.username = '',
    this.password = '',
    this.email = '',
    this.nama = '',
    this.tanggalLahir = '',
    this.jenisKelamin = '',
    this.umur = 0,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: '',
      email: map['email'],
      nama: map['nama'],
      tanggalLahir: map['tanggal_lahir'],
      jenisKelamin: map['jenis_kelamin'],
      umur: getUmur(map['tanggal_lahir']),
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

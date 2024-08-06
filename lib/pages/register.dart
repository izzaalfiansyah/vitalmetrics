import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/dates.dart';
import 'package:vitalmetrics/libs/notif.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/pages/login.dart';
import 'package:vitalmetrics/services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  DateTime? tanggalLahir;
  String jenisKelamin = '';

  handleRegister(ctx) async {
    String tanggalLahirString = tanggalLahir != null
        ? tanggalLahir!.toIso8601String().substring(0, 10)
        : '';

    final res = await UserService.register(User(
      username: username.text,
      email: email.text,
      nama: nama.text,
      tanggalLahir: tanggalLahirString,
      jenisKelamin: jenisKelamin,
      password: password.text,
      passwordConfirmation: passwordConfirmation.text,
    ));

    notif(
      ctx,
      text: res.success
          ? 'Berhasil registrasi akun. Silahkan login ke akun anda'
          : res.message,
      color: res.success ? null : Colors.red,
    );

    if (res.success) {
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    "Buat Akun Baru",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  AuthTextField(
                    label: 'Username',
                    hint: 'Masukkan Username',
                    controller: username,
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    label: 'Email',
                    hint: 'Masukkan Email',
                    controller: email,
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    label: 'Nama',
                    hint: 'Masukkan Nama',
                    controller: nama,
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tanggal Lahir'),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: tanggalLahir != null
                                ? formatDate(tanggalLahir!.toIso8601String())
                                : 'Pilih Tanggal Lahir',
                            border: InputBorder.none,
                          ),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1970),
                              initialDate: tanggalLahir,
                              lastDate: DateTime.now(),
                            );

                            if (date != null) {
                              setState(() {
                                tanggalLahir = date;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jenis Kelamin'),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          value: jenisKelamin,
                          items: [
                            {
                              'value': '',
                              'label': 'Pilih Gender',
                            },
                            {
                              'value': 'l',
                              'label': 'Laki-laki',
                            },
                            {
                              'value': 'p',
                              'label': 'Perempuan',
                            },
                          ]
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item['value'],
                                  child: Text(item['label']!),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              jenisKelamin = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    label: 'Password',
                    hint: 'Masukkan Password',
                    controller: password,
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  AuthTextField(
                    label: 'Konfirmasi Password',
                    hint: 'Masukkan Konfirmasi Password',
                    controller: passwordConfirmation,
                    isPassword: true,
                  ),
                  SizedBox(height: 40),
                  FilledButton(
                    onPressed: () {
                      handleRegister(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: cPrimary,
                      fixedSize: Size.fromWidth(size.width),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('DAFTAR'),
                  ),
                ],
              ),
              SizedBox(height: 80),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Sudah punya akun? login '),
                      TextSpan(
                        text: 'disini',
                        style: TextStyle(
                          color: cPrimary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

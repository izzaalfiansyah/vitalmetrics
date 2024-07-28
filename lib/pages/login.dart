import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/notif.dart';
import 'package:vitalmetrics/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    handleLogin(ctx) async {
      final res = await UserService.login(
          username: username.text, password: password.text);

      notif(
        ctx,
        text: res.success ? 'Berhasil login. Mengalihkan...' : res.message,
        color: res.success ? null : Colors.red,
      );

      if (res.success) {
        // ignore: use_build_context_synchronously
        context.read<UserBloc>().add(UserGet());

        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacementNamed('/');
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login ke Akunmu",
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
                      label: 'Password',
                      hint: 'Masukkan Password',
                      controller: password,
                      isPassword: true,
                    ),
                    SizedBox(height: 40),
                    FilledButton(
                      onPressed: () {
                        handleLogin(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: cPrimary,
                        fixedSize: Size.fromWidth(size.width),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('MASUK'),
                    ),
                  ],
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Belum punya akun? daftar '),
                      TextSpan(
                        text: 'disini',
                        style: TextStyle(
                          color: cPrimary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('go to register page');
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

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.isPassword = false,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? !showPassword : false,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: cPrimary),
            ),
            border: OutlineInputBorder(),
            hintText: widget.hint,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

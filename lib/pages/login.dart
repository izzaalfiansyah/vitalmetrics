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
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  handleLogin(ctx) async {
    setState(() {
      isLoading = true;
    });
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

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
                      label: 'Email/Username',
                      hint: 'Masukkan Email atau Username',
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
                      onPressed: isLoading
                          ? null
                          : () {
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
                            Navigator.of(context).pushNamed('/register');
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: widget.isPassword ? !showPassword : false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hint,
                    // suffixIcon: Icon(Icons.visibility_outlined),
                    // suffix: widget.isPassword
                    //     ? IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             showPassword = !showPassword;
                    //           });
                    //         },
                    //         icon: Icon(
                    //           showPassword
                    //               ? Icons.visibility_outlined
                    //               : Icons.visibility_off_outlined,
                    //           size: 20,
                    //         ),
                    //       )
                    //     : null,
                  ),
                ),
              ),
              widget.isPassword
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}

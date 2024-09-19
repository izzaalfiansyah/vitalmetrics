import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/categories_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    handleTimer();
  }

  void handleTimer() async {
    const duration = Duration(seconds: 2);
    await context.read<UserBloc>().getUser();
    await context.read<CategoriesBloc>().getAll();

    Timer(duration, () {
      bool isLogin = context.read<UserBloc>().state.isLogin;
      Navigator.of(context).pushReplacementNamed(isLogin ? '/' : '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPrimary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/polijefull.png',
                          height: 60,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "powered by PNBP Politeknik Negeri Jember"
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.heart_broken_rounded,
                size: 140,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}

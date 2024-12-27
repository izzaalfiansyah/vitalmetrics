import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/categories_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';

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
    await context.read<CategoriesBloc>().getAll();
    await context.read<UserBloc>().getUser();

    Future.delayed(Duration(milliseconds: 1500), () {
      bool isLogin = context.read<UserBloc>().state.isLogin;
      Navigator.of(context).pushReplacementNamed(isLogin ? '/' : '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        Text(
                          "powered by PNBP Politeknik Negeri Jember"
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            // color: Colors.white,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/esmart.png',
                  width: 250,
                  height: 250,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

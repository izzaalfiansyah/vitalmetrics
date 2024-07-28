import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/pages/akun.dart';
import 'package:vitalmetrics/pages/akun/manajemen.dart';
import 'package:vitalmetrics/pages/akun/perangkat.dart';
import 'package:vitalmetrics/pages/login.dart';
import 'package:vitalmetrics/pages/riwayat.dart';
import 'package:vitalmetrics/pages/index.dart';
import 'package:vitalmetrics/pages/report.dart';
import 'package:vitalmetrics/pages/ukur/index.dart';
import 'package:vitalmetrics/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserBloc userBloc = UserBloc();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    userBloc.add(UserGet());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userBloc,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Vitalmetrics',
            theme: ThemeData(
              textTheme: GoogleFonts.interTextTheme(),
              colorScheme: ColorScheme.fromSeed(
                seedColor: cPrimary,
              ),
              scaffoldBackgroundColor: Colors.grey[50],
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                backgroundColor: cPrimary,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: cPrimary,
              ),
            ),
            debugShowCheckedModeBanner: false,
            // home: const SplashScreen(),
            routes: {
              '/splash': (context) => SplashScreen(),
              '/login': (context) => LoginScreen(),
              '/': (context) => IndexScreen(),
              '/ukur': (context) => UkurScreen(),
              '/report': (context) => ReportScreen(),
              '/riwayat': (context) => RiwayatScreen(),
              '/akun': (context) => AkunScreen(),
              '/akun/manajemen': (context) => AkunManajemenScreen(),
              '/akun/perangkat': (context) => AkunPerangkatScreen(),
            },
            initialRoute: '/splash',
          );
        },
      ),
    );
  }
}

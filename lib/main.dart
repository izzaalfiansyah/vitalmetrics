import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/pages/akun.dart';
import 'package:vitalmetrics/pages/account/manajemen.dart';
import 'package:vitalmetrics/pages/riwayat.dart';
import 'package:vitalmetrics/pages/index.dart';
import 'package:vitalmetrics/pages/report.dart';
import 'package:vitalmetrics/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setUserId(1.toString());

    return MaterialApp(
      title: 'Flutter Demo',
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
        '/': (context) => IndexScreen(),
        '/report': (context) => ReportScreen(),
        '/history': (context) => RiwayatScreen(),
        '/account': (context) => AkunScreen(),
        '/account/management': (context) => AkunManajemenScreen(),
      },
      initialRoute: '/splash',
    );
  }
}

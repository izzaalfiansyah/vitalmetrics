import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/pages/account.dart';
import 'package:vitalmetrics/pages/history.dart';
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
      ),
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => IndexScreen(),
        '/report': (context) => ReportScreen(),
        '/history': (context) => HistoryScreen(),
        '/account': (context) => AccountScreen(),
      },
      initialRoute: '/splash',
    );
  }
}

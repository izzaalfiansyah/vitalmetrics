import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/routes.dart';

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
            routes: routes,
            initialRoute: '/splash',
          );
        },
      ),
    );
  }
}

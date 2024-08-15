import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/pages/admin.dart';
import 'package:vitalmetrics/pages/akun.dart';
import 'package:vitalmetrics/pages/akun/manajemen.dart';
import 'package:vitalmetrics/pages/akun/perangkat.dart';
import 'package:vitalmetrics/pages/index.dart';
import 'package:vitalmetrics/pages/login.dart';
import 'package:vitalmetrics/pages/register.dart';
import 'package:vitalmetrics/pages/report.dart';
import 'package:vitalmetrics/pages/riwayat.dart';
import 'package:vitalmetrics/pages/ukur/index.dart';
import 'package:vitalmetrics/pages/user/detail.dart';
import 'package:vitalmetrics/pages/user/index.dart';
import 'package:vitalmetrics/splash.dart';

Map<String, WidgetBuilder> routes = {
  '/splash': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/': (context) => context.read<UserBloc>().state.item?.role == '1'
      ? AdminScreen()
      : IndexScreen(),
  '/ukur': (context) => UkurScreen(),
  '/user': (context) => UserListScreen(),
  '/user/detail': (context) => UserDetailScreen(),
  '/report': (context) => ReportScreen(),
  '/riwayat': (context) => RiwayatScreen(),
  '/akun': (context) => AkunScreen(),
  '/akun/manajemen': (context) => AkunManajemenScreen(),
  '/akun/perangkat': (context) => AkunPerangkatScreen(),
};

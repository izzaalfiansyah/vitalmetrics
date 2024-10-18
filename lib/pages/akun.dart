// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/libs/notif.dart';
import 'package:vitalmetrics/services/user_service.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 120),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: cPrimary,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Memuat....',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }

                    if (state.item != null) {
                      final user = state.item;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(width: 8),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user != null ? user.nama : '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                user != null ? user.email : '',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }

                    return Text(
                      'Terjadi kesalahan',
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/akun/manajemen');
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowBase,
              ),
              child: Column(
                children: [
                  tileItem(
                    label: 'Manajemen Pengguna',
                    icon: Icons.account_box,
                    onTap: () {
                      Navigator.of(context).pushNamed('/akun/manajemen');
                    },
                  ),
                  Hr(),
                  tileItem(
                    icon: Icons.devices,
                    label: 'Perangkat Saya',
                    onTap: () {
                      Navigator.of(context).pushNamed('/akun/perangkat');
                    },
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: shadowBase,
            //   ),
            //   child: Column(
            //     children: [
            //       tileItem(label: 'Target Bobot', icon: Icons.monitor_weight),
            //       Hr(),
            //       tileItem(
            //           icon: Icons.pie_chart_outline_rounded,
            //           label: 'Target Lemak'),
            //       Hr(),
            //       tileItem(icon: Icons.card_membership, label: 'Tujuan BMI'),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowBase,
              ),
              child: Column(
                children: [
                  // tileItem(icon: Icons.settings, label: 'Pengaturan'),
                  tileItem(
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                'Anda yakin untuk keluar? Sesi anda akan diakhiri.'),
                            actionsPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final res = await UserService.logout();

                                  notif(
                                    context,
                                    text: res.success
                                        ? "Berhasil logout. mengalihkan..."
                                        : res.message,
                                  );

                                  if (res.success) {
                                    await Future.delayed(Duration(seconds: 2));
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  }
                                },
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  ListTile tileItem(
      {required IconData icon, required String label, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey.shade400,
      ),
      title: Text(label),
      trailing: Icon(
        Icons.chevron_right,
        color: cPrimary.withOpacity(.8),
      ),
      onTap: onTap,
    );
  }
}

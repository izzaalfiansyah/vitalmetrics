import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/services/user.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  String userId = '';

  @override
  void initState() {
    getUserId().then((val) {
      setState(() {
        userId = val;
      });
    });
    super.initState();
  }

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
                FutureBuilder(
                    future: UserService.find(userId),
                    builder: (context, snapshot) {
                      final user = snapshot.data;

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
                    }),
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
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowBase,
              ),
              child: Column(
                children: [
                  tileItem(label: 'Target Bobot', icon: Icons.monitor_weight),
                  Hr(),
                  tileItem(
                      icon: Icons.pie_chart_outline_rounded,
                      label: 'Target Lemak'),
                  Hr(),
                  tileItem(icon: Icons.card_membership, label: 'Tujuan BMI'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowBase,
              ),
              child: Column(
                children: [
                  tileItem(icon: Icons.settings, label: 'Pengaturan'),
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

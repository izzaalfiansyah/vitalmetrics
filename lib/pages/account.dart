import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                Row(
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
                          'Muhammad Izza Alfiansyah',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'iansyah724@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
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
                      label: 'Manajemen Pengguna', icon: Icons.account_box),
                  tileDivider(),
                  tileItem(icon: Icons.devices, label: 'Perangkat Saya'),
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
                  tileDivider(),
                  tileItem(
                      icon: Icons.pie_chart_outline_rounded,
                      label: 'Target Lemak'),
                  tileDivider(),
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

  Container tileDivider() {
    return Container(
      color: Colors.grey.shade100,
      height: 1,
    );
  }

  ListTile tileItem({required IconData icon, required String label}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey.shade300,
      ),
      title: Text(label),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade400,
      ),
    );
  }
}

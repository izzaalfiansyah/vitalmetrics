import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Admin screen'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

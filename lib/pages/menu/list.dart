import 'package:flutter/material.dart';
import 'package:vitalmetrics/pages/menu/index.dart';

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({
    super.key,
    required this.category,
  });
  final MenuCategoryByAge category;

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu ${widget.category.label}'),
      ),
      body: Center(
        child: Text('List menu'),
      ),
    );
  }
}

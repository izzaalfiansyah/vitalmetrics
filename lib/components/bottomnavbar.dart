import 'package:flutter/material.dart';
import 'package:vitalmetrics/constant.dart';

class Menu {
  final IconData icon;
  final String label;
  final String path;

  Menu({
    required this.icon,
    required this.label,
    required this.path,
  });
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final String routeLocation =
        ModalRoute.of(context)!.settings.name.toString();
    final List<Menu> menus = [
      Menu(icon: Icons.home, label: 'Beranda', path: '/'),
      Menu(icon: Icons.history, label: 'Riwayat', path: '/history'),
      Menu(icon: Icons.account_circle, label: 'Saya', path: '/account'),
    ];

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedLabelStyle: TextStyle(
        color: cPrimary,
      ),
      currentIndex: menus.indexWhere((menu) => menu.path == routeLocation),
      onTap: (index) {
        final menu = menus[index];
        if (menu.path == '/') {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(menu.path, (route) => false);
        } else {
          Navigator.of(context).pushNamed(menu.path);
        }
      },
      items: menus
          .map((menu) => BottomNavigationBarItem(
                icon: Icon(
                  menu.icon,
                  color: routeLocation == menu.path ? cPrimary : null,
                ),
                label: menu.label,
              ))
          .toList(),
    );
  }
}

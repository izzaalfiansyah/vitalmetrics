import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
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
  final List<Menu> userMenus = [
    Menu(icon: Icons.home, label: 'Beranda', path: '/'),
    Menu(icon: Icons.history, label: 'Riwayat', path: '/riwayat'),
    Menu(icon: Icons.account_circle, label: 'Saya', path: '/akun'),
  ];
  final List<Menu> adminMenus = [
    Menu(icon: Icons.home, label: 'Beranda', path: '/'),
    Menu(icon: Icons.supervisor_account, label: 'User', path: '/user'),
    Menu(icon: Icons.fastfood, label: 'Menu', path: '/menu'),
    Menu(icon: Icons.account_circle, label: 'Saya', path: '/akun'),
  ];
  List<Menu> menus = [];
  bool isAdmin = false;

  @override
  void initState() {
    String role = context.read<UserBloc>().state.item!.role;
    setState(() {
      isAdmin = role == '1';
      menus = isAdmin ? adminMenus : userMenus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String routeLocation =
        ModalRoute.of(context)!.settings.name.toString();

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey.withOpacity(.85),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: cPrimary,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: menus.indexWhere((menu) => menu.path == routeLocation),
      onTap: (index) {
        final menu = menus[index];
        if (menu.path == '/') {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(menu.path, (route) => false);
        } else {
          if (routeLocation != menu.path) {
            Navigator.of(context).pushNamed(menu.path);
          }
        }
      },
      items: menus
          .map((menu) => BottomNavigationBarItem(
                icon: Icon(
                  menu.icon,
                ),
                label: menu.label,
              ))
          .toList(),
    );
  }
}

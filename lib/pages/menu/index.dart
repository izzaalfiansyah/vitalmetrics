import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/pages/menu/list.dart';

class MenuCategoryByAge {
  final String label;
  final int umurMin;
  final int umurMax;
  final IconData icon;

  MenuCategoryByAge({
    required this.label,
    required this.umurMin,
    required this.umurMax,
    required this.icon,
  });
}

final categoryAge = [
  MenuCategoryByAge(
    label: 'Anak',
    umurMin: 1,
    umurMax: 12,
    icon: Icons.child_care,
  ),
  MenuCategoryByAge(
    label: 'Remaja',
    umurMin: 13,
    umurMax: 18,
    icon: Icons.add_reaction_outlined,
  ),
  MenuCategoryByAge(
    label: 'Dewasa',
    umurMin: 19,
    umurMax: 44,
    icon: Icons.accessibility_new,
  ),
  MenuCategoryByAge(
    label: 'Lansia',
    umurMin: 45,
    umurMax: 100,
    icon: Icons.assist_walker,
  ),
];

class MenuCategoryByAgeScreen extends StatefulWidget {
  const MenuCategoryByAgeScreen({super.key});

  @override
  State<MenuCategoryByAgeScreen> createState() =>
      _MenuCategoryByAgeScreenState();
}

class _MenuCategoryByAgeScreenState extends State<MenuCategoryByAgeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Menu'),
        leading: SizedBox(),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: size.aspectRatio * 1.5,
        ),
        itemCount: categoryAge.length,
        itemBuilder: (context, index) {
          final item = categoryAge[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MenuListScreen(
                    category: item,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowBase,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 80,
                    color: cPrimary,
                  ),
                  SizedBox(height: 10),
                  Text(item.label.toUpperCase()),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

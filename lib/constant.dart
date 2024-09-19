import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/category_label.dart';

const cPrimary = Colors.pink;
final borderBase = BorderSide(color: Colors.grey.withOpacity(.1), width: 1);
final shadowBase = [
  BoxShadow(color: Colors.grey.withOpacity(.25), blurRadius: 4),
];

List<CategoryRange> getLemakTubuhCategory({String gender = 'l'}) {
  return [
    CategoryRange(
      range: gender == 'l' ? [6, 13] : [14, 20],
      result: 'Sangat Sehat',
      color: 'blue',
    ),
    CategoryRange(
      range: gender == 'l' ? [13, 17] : [20, 24],
      result: 'Sehat',
      color: 'green',
    ),
    CategoryRange(
      range: gender == 'l' ? [17, 24] : [24, 31],
      result: 'Cukup Sehat',
      color: 'yellow',
    ),
    CategoryRange(
      range: gender == 'l' ? [24, 40] : [31, 50],
      result: 'Tidak Sehat',
      color: 'red',
    ),
  ];
}

class WaktuMenu {
  final String title;
  final dynamic id;

  WaktuMenu({
    required this.title,
    required this.id,
  });
}

final waktuMenu = [
  WaktuMenu(title: 'Makan Pagi', id: '1'),
  WaktuMenu(title: 'Selingan Pagi', id: '2'),
  WaktuMenu(title: 'Makan Siang', id: '3'),
  WaktuMenu(title: 'Selingan Sore', id: '4'),
  WaktuMenu(title: 'Makan Malam', id: '5'),
];

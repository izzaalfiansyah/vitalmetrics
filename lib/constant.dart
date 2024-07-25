import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/category_label.dart';

const cPrimary = Colors.pink;
final borderBase = BorderSide(color: Colors.grey.withOpacity(.1), width: 1);
final shadowBase = [
  BoxShadow(color: Colors.grey.withOpacity(.25), blurRadius: 4),
];

List<Category> getSkorBadanCategory() {
  return [
    Category(
      range: [0, 40],
      result: 'Tidak Sehat',
      color: Colors.red,
    ),
    Category(
      range: [40, 60],
      result: 'Cukup Sehat',
      color: Colors.orange,
    ),
    Category(
      range: [60, 80],
      result: 'Sehat',
      color: Colors.green,
    ),
    Category(
      range: [80, 100],
      result: 'Sangat Sehat',
      color: Colors.cyan,
    ),
  ];
}

List<Category> getLemakTubuhCategory({String gender = 'l'}) {
  return [
    Category(
      range: gender == 'l' ? [6, 13] : [14, 20],
      result: 'Sangat Sehat',
      color: Colors.cyan,
    ),
    Category(
      range: gender == 'l' ? [13, 17] : [20, 24],
      result: 'Sehat',
      color: Colors.green,
    ),
    Category(
      range: gender == 'l' ? [17, 24] : [24, 31],
      result: 'Cukup Sehat',
      color: Colors.orange,
    ),
    Category(
      range: gender == 'l' ? [24, 40] : [31, 50],
      result: 'Tidak Sehat',
      color: Colors.red,
    ),
  ];
}

List<Category> getBmiCategory() {
  return [
    Category(
      range: [0, 18.5],
      result: 'Kurus',
      color: Colors.orange,
    ),
    Category(
      range: [18.5, 25],
      result: 'Sehat',
      color: Colors.green,
    ),
    Category(
      range: [25, 30],
      result: 'Gemuk',
      color: Colors.orange,
    ),
    Category(
      range: [30, 45],
      result: 'Obesitas',
      color: Colors.red,
    ),
  ];
}

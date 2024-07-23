import 'package:flutter/material.dart';
import 'package:vitalmetrics/constant.dart';

// ignore: must_be_immutable
class BodyLoading extends StatelessWidget {
  Color? color;

  BodyLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: color ?? cPrimary),
          SizedBox(height: 20),
          Text(
            'Memuat...',
            style: TextStyle(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vitalmetrics/constant.dart';

class Hr extends StatelessWidget {
  const Hr({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: color ?? borderBase.color,
          ),
        ),
      ),
    );
  }
}

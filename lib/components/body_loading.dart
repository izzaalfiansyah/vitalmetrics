import 'package:flutter/material.dart';
import 'package:vitalmetrics/constant.dart';

class BodyLoading extends StatelessWidget {
  const BodyLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: cPrimary),
          SizedBox(height: 5),
          Text('Memuat...'),
        ],
      ),
    );
  }
}

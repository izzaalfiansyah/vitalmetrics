import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/rumus.dart';
import 'package:vitalmetrics/pages/report.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  double tinggi = 0, berat = 0, umur = 0, bmi = 0, lemak = 0;
  String jenisKelamin = "l";

  @override
  void initState() {
    super.initState();
    tinggi = 165;
    berat = 45;

    bmi = getBMI(tinggi: tinggi, berat: berat, umur: umur);
    lemak = getLemakTubuh(jenisKelamin: jenisKelamin, bmi: bmi, umur: umur);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VitalMetrics'.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/akun');
            },
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 1 / 4,
              decoration: BoxDecoration(
                color: cPrimary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          displayBox(
                            label: 'Berat'.toUpperCase(),
                            value: berat,
                            maxValue: 200,
                            pcs: 'KG',
                          ),
                          displayBox(
                            backgroundColor: cPrimary,
                            label: 'Tinggi'.toUpperCase(),
                            value: tinggi,
                            maxValue: 300,
                            pcs: 'CM',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  // padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowBase,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          classificationItem(
                            size,
                            icon: Icons.card_membership,
                            title: 'BMI',
                            resultValue: bmi.toStringAsFixed(1),
                            resultText: 'Sehat',
                            resultColor: Colors.green,
                          ),
                          classificationItem(
                            size,
                            icon: Icons.sports_score,
                            title: 'Skor badan',
                            resultValue: '73',
                            resultText: 'Sehat',
                            resultColor: Colors.green,
                          ),
                          classificationItem(
                            size,
                            icon: Icons.pie_chart_outline_sharp,
                            title: 'Lemak Tubuh',
                            resultValue: '${lemak.toStringAsFixed(1)}%',
                            resultText: 'Berlebihan',
                            resultColor: Colors.red,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: cPrimary,
                            fixedSize: Size.fromWidth(size.width),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/report',
                                arguments: ReportArguments(id: ''));
                          },
                          child: Text(
                            'SELENGKAPNYA',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Container displayBox({
    required String label,
    required double value,
    required double maxValue,
    required String pcs,
    Color? backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      color: backgroundColor ?? Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: backgroundColor != null ? Colors.white : cPrimary,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value.toString(),
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(text: pcs)
                ],
                style: TextStyle(
                    color: (backgroundColor != null ? Colors.white : cPrimary)),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: maxValue,
            value: value,
            thumbColor: (backgroundColor != null ? Colors.white : cPrimary),
            activeColor: (backgroundColor != null ? Colors.white : cPrimary),
            inactiveColor: (backgroundColor != null ? Colors.white : cPrimary)
                .withOpacity(.35),
            onChanged: (val) {},
          )
        ],
      ),
    );
  }

  Expanded classificationItem(Size size,
      {required IconData icon,
      required String resultValue,
      required String title,
      required String resultText,
      required Color resultColor}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: borderBase,
            left: borderBase.copyWith(width: .5),
            right: borderBase.copyWith(width: .5),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            SizedBox(height: 3),
            Text(
              resultValue,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: cPrimary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: resultColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50),
                  right: Radius.circular(50),
                ),
              ),
              child: Text(
                resultText,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

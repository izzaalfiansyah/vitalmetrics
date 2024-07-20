import 'package:flutter/material.dart';
import 'package:vitalmetrics/constant.dart';

class ReportArguments {
  final String id;

  ReportArguments({required this.id});
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ReportArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Kesehatan',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: cPrimary,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      topItem(
                        size,
                        text: 'Berat Badan',
                        value: '54',
                        satuan: 'KG',
                      ),
                      topItem(
                        size,
                        text: 'Tinggi Badan',
                        value: '165',
                        satuan: 'CM',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.white,
                      thickness: .25,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        'Bandingkan dengan 22 Juni 2024 21:00',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          topSubItem(
                            size,
                            label: 'BMI',
                            up: true,
                            value: '26.4',
                          ),
                          topSubItem(
                            size,
                            label: 'Skor Badan',
                            up: true,
                            value: '73',
                          ),
                          topSubItem(
                            size,
                            label: 'Lemak Tubuh',
                            up: false,
                            value: '17.7 %',
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              child: Text(
                'Komposisi Badan',
                style: TextStyle(
                  color: cPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                listItem(label: "Berat", value: "71.8kg"),
                listItem(label: "BMI", value: "26.4"),
                listItem(label: "Berat", value: "71.8kg"),
                listItem(label: "BMI", value: "26.4"),
                listItem(label: "Berat", value: "71.8kg"),
                listItem(label: "BMI", value: "26.4"),
              ],
            ),
            Container(
              height: 20,
              color: Colors.grey.shade200,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              child: Text(
                'Manajemen Badan',
                style: TextStyle(
                  color: cPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                listItem(label: "Berat", value: "71.8kg"),
                listItem(label: "BMI", value: "26.4"),
                listItem(label: "Berat", value: "71.8kg"),
                listItem(label: "BMI", value: "26.4"),
                listItem(label: "Berat", value: "71.8kg"),
                listItem(label: "BMI", value: "26.4"),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: cPrimary,
                  fixedSize: Size.fromWidth(size.width),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text('HAPUS'),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  InkWell listItem({required String label, required String value}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              value,
              style: TextStyle(
                color: cPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container topSubItem(
    Size size, {
    required bool up,
    required String label,
    required String value,
  }) {
    return Container(
      width: size.width / 3,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                up ? Icons.trending_up : Icons.trending_down,
                color: Colors.yellow,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 11,
            ),
          )
        ],
      ),
    );
  }

  Container topItem(Size size,
      {required String text, required String value, required String satuan}) {
    return Container(
      alignment: Alignment.center,
      width: size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: ' $satuan',
                  style: TextStyle(fontSize: 12),
                ),
              ],
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

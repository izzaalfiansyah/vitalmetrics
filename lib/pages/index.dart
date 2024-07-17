import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/pages/report.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  double _height = 0;
  double _weight = 0;

  @override
  void initState() {
    super.initState();
    _height = 165;
    _weight = 54;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              height: size.height * .9 / 3,
              decoration: BoxDecoration(
                color: cPrimary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'VITALMETRICS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 90),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: shadowBase,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BERAT',
                                style: TextStyle(color: cPrimary),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: _weight.toString(),
                                        style: TextStyle(
                                          fontSize: 46,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(text: 'KG')
                                    ],
                                    style: TextStyle(color: cPrimary),
                                  ),
                                ),
                              ),
                              Slider(
                                min: 0,
                                max: 150,
                                value: _weight,
                                thumbColor: cPrimary,
                                activeColor: cPrimary,
                                inactiveColor: cPrimary.shade100,
                                onChanged: (val) {},
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 14),
                        Container(
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: cPrimary.withOpacity(.95),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: shadowBase,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TINGGI',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: _height.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 46,
                                        ),
                                      ),
                                      TextSpan(text: 'CM')
                                    ],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Slider(
                                min: 0,
                                max: 300,
                                value: _height,
                                thumbColor: Colors.white,
                                activeColor: Colors.white,
                                inactiveColor: cPrimary.shade200,
                                onChanged: (val) {},
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40),
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
                              resultValue: '26.4',
                              resultText: 'Sehat',
                              resultColor: Colors.green,
                            ),
                            classificationItem(
                              size,
                              icon: Icons.pie_chart_outline_sharp,
                              title: 'Lemak Tubuh',
                              resultValue: '27.2%',
                              resultText: 'Berlebihan',
                              resultColor: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/report',
                                  arguments: ReportArguments(id: ''));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: cPrimary,
                                boxShadow: shadowBase,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                'SELENGKAPNYA',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Expanded classificationItem(Size size,
      {required IconData icon,
      required String resultValue,
      required String title,
      required String resultText,
      required Color resultColor}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          SizedBox(height: 5),
          Text(
            resultValue,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: cPrimary,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 2),
          Container(
            alignment: Alignment.center,
            width: 100,
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
    );
  }
}

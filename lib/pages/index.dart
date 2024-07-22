import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vitalmetrics/bloc/pengukuran_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/dates.dart';
import 'package:vitalmetrics/libs/rumus.dart';
import 'package:vitalmetrics/models/pengukuran.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/pages/report.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  PengukuranBloc pengukuranBloc = PengukuranBloc();

  @override
  void initState() {
    pengukuranBloc.add(PengukuranGetLatest());
    super.initState();
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
        leading: SizedBox(),
        leadingWidth: 0,
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
      body: BlocProvider(
        create: (context) => pengukuranBloc,
        child: BlocBuilder<PengukuranBloc, PengukuranState>(
          builder: (context, state) {
            Pengukuran dataTerakhir = Pengukuran(),
                dataPembanding = Pengukuran();

            if (state.items != null) {
              if (state.items!.isNotEmpty) {
                dataTerakhir = state.items?[0] ?? Pengukuran();
                dataPembanding = state.items?[1] ?? Pengukuran();
              }
            }

            User user = context.read<UserBloc>().state.item ?? User();

            double bmiTerakhir = getBMI(
                  tinggi: dataTerakhir.tinggi,
                  berat: dataTerakhir.berat,
                  umur: dataTerakhir.userUmur,
                ),
                bmiPembanding = getBMI(
                  tinggi: dataPembanding.tinggi,
                  berat: dataPembanding.berat,
                  umur: dataPembanding.userUmur,
                );

            double lemakTerakhir = getLemakTubuh(
                    jenisKelamin: user.jenisKelamin,
                    bmi: bmiTerakhir,
                    umur: user.umur),
                lemakPembanding = getLemakTubuh(
                    jenisKelamin: user.jenisKelamin,
                    bmi: bmiPembanding,
                    umur: user.umur);

            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: size.height * 1 / 2,
                    decoration: BoxDecoration(
                      color: cPrimary,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(60),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              displayBox(
                                label: 'Berat',
                                value: dataTerakhir.berat,
                                pcs: 'KG',
                                maxValue: 200,
                              ),
                              displayBox(
                                label: 'Tinggi',
                                value: dataTerakhir.tinggi,
                                pcs: 'CM',
                                maxValue: 300,
                              ),
                              SizedBox(height: 20),
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // perangkatTidakTerhubung(),
                  Container(
                    padding: EdgeInsets.only(
                      top: size.height * 1 / 2 - 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          // height: 200,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowBase,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  formatDateTime(dataTerakhir.createdAt),
                                  style: TextStyle(
                                    color: cPrimary,
                                    // fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Hr(),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  perbandinganItem(
                                    label: 'BMI',
                                    value: bmiTerakhir - bmiPembanding,
                                    naik: bmiTerakhir - bmiPembanding > 0,
                                  ),
                                  perbandinganItem(
                                    label: 'Skor Badan',
                                    value: 0,
                                    naik: false,
                                  ),
                                  perbandinganItem(
                                    label: 'Lemak (%)',
                                    value: lemakTerakhir - lemakPembanding,
                                    naik: lemakTerakhir - lemakPembanding > 0,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Bandingkan dengan 20 Juli 2024 15:00',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          // padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowBase,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  classificationItem(
                                    size,
                                    icon: Icons.card_membership,
                                    title: 'BMI',
                                    resultValue: bmiTerakhir.toStringAsFixed(1),
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
                                    resultValue:
                                        '${lemakTerakhir.toStringAsFixed(1)}%',
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
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Container perangkatTidakTerhubung() {
    return Container(
      width: double.infinity,
      color: Colors.orange,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        'Perangkat tidak terhubung'.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Expanded perbandinganItem({
    required String label,
    required double value,
    bool naik = false,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${naik ? '+' : ''}${value.toStringAsFixed(1)}',
            style: TextStyle(
              color: cPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                naik ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.orange,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container displayBox({
    required String label,
    required double value,
    required String pcs,
    required double maxValue,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                RichText(
                    text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: value.toStringAsFixed(1),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    TextSpan(text: ' $pcs')
                  ],
                ))
              ],
            ),
          ),
          SizedBox(height: 5),
          SfLinearGauge(
            animationDuration: 0,
            axisLabelStyle: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
            axisTrackStyle: LinearAxisTrackStyle(
              color: Colors.white.withOpacity(.55),
            ),
            majorTickStyle: LinearTickStyle(
              color: Colors.white.withOpacity(.55),
              length: 10,
            ),
            minorTickStyle: LinearTickStyle(
              color: Colors.white.withOpacity(.55),
              length: 4,
            ),
            minimum: 0,
            maximum: maxValue,
            barPointers: [
              LinearBarPointer(
                animationDuration: 0,
                value: value,
                color: Colors.white,
              ),
            ],
            markerPointers: [
              LinearShapePointer(
                animationDuration: 0,
                value: value,
                color: Colors.white,
              ),
            ],
          ),
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

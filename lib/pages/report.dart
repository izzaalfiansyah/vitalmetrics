import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vitalmetrics/bloc/pengukuran_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/dates.dart';
import 'package:vitalmetrics/models/pengukuran.dart';

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
  PengukuranBloc pengukuranBloc = PengukuranBloc();

  @override
  void initState() {
    final userId = context.read<UserBloc>().state.id;
    pengukuranBloc.add(PengukuranGetLatest(userId: userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
      body: BlocBuilder<PengukuranBloc, PengukuranState>(
        bloc: pengukuranBloc,
        builder: (context, state) {
          Pengukuran dataTerakhir = Pengukuran(), dataPembanding = Pengukuran();

          bool pembandingIsEmpty = true;

          if (state.items != null) {
            if (state.items!.isNotEmpty) {
              dataTerakhir = state.items?[0] ?? Pengukuran();

              if (state.items!.length > 1) {
                pembandingIsEmpty = false;
                dataPembanding = state.items?[1] ?? Pengukuran();
              }
            }
          }

          if (state.isLoading) {
            return Center(
              child: BodyLoading(),
            );
          }

          return SingleChildScrollView(
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
                            value: dataTerakhir.berat.toStringAsFixed(1),
                            satuan: 'KG',
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 180,
                              child: SfRadialGauge(
                                title: GaugeTitle(
                                  text: 'Skor Badan',
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                axes: [
                                  RadialAxis(
                                    minimum: 0,
                                    maximum: 100,
                                    axisLineStyle: AxisLineStyle(
                                      color: Colors.white.withOpacity(.5),
                                      thickness: 5,
                                    ),
                                    showLabels: false,
                                    showTicks: false,
                                    pointers: [
                                      RangePointer(
                                        value: 73,
                                        color: Colors.white,
                                        enableAnimation: true,
                                        width: 5,
                                      ),
                                    ],
                                    annotations: [
                                      GaugeAnnotation(
                                        widget: Text(
                                          '73',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          topItem(
                            size,
                            text: 'Tinggi Badan',
                            value: dataTerakhir.tinggi.toStringAsFixed(1),
                            satuan: 'CM',
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          formatDateTime(dataTerakhir.createdAt),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Hr(
                          color: Colors.white.withOpacity(.5),
                        ),
                      ),
                      Column(
                        children: [
                          pembandingIsEmpty
                              ? SizedBox()
                              : Text(
                                  'Bandingkan dengan ${formatDateTime(dataPembanding.createdAt)}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              topSubItem(
                                size,
                                label: 'BMI',
                                value: dataTerakhir.bmi - dataPembanding.bmi,
                              ),
                              topSubItem(
                                size,
                                label: 'Skor Badan',
                                value: 0,
                              ),
                              topSubItem(
                                size,
                                label: 'Lemak (%)',
                                value: dataTerakhir.lemakTubuh -
                                    dataPembanding.lemakTubuh,
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
                Hr(),
                Column(
                  children: [
                    listItem(
                      label: "Berat",
                      value: '${dataTerakhir.berat.toStringAsFixed(1)}kg',
                    ),
                    listItem(
                      label: "BMI",
                      value: dataTerakhir.bmi.toStringAsFixed(1),
                    ),
                    listItem(
                      label: "Lemak Tubuh",
                      value: '${dataTerakhir.lemakTubuh.toStringAsFixed(1)}%',
                    ),
                    listItem(
                      label: "Air Dalam Tubuh",
                      value: "26.4",
                    ),
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
                Hr(),
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
          );
        },
      ),
    );
  }

  Widget listItem({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: borderBase,
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
    );
  }

  Container topSubItem(
    Size size, {
    required String label,
    required double value,
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
                value > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: value > 0 ? Colors.green : Colors.yellow,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                value.toStringAsFixed(1),
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

  Widget topItem(
    Size size, {
    required String text,
    required String value,
    required String satuan,
    bool important = false,
  }) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
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
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: important ? 50 : 30,
                      fontWeight: important ? FontWeight.w500 : null,
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
      ),
    );
  }
}

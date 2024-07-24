import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vitalmetrics/bloc/pengukuran_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/models/chartdata.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  PengukuranBloc pengukuranBloc = PengukuranBloc();

  String filterWaktu = 'Hari';
  String filterKategori = "Berat";

  @override
  void initState() {
    getReport();
    super.initState();
  }

  getReport() {
    final userId = context.read<UserBloc>().state.id;
    pengukuranBloc.add(PengukuranGetReport(
        userId: userId, tipe: '${filterWaktu.toLowerCase()}an'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Riwayat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        backgroundColor: cPrimary,
        leading: SizedBox(),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: ['Hari', 'Minggu', 'Bulan', 'Tahun']
                    .map((item) => phillSelect(label: item))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => pengukuranBloc,
              child: BlocBuilder<PengukuranBloc, PengukuranState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return BodyLoading();
                  }

                  if (state.items != null) {
                    return SfCartesianChart(
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        activationMode: ActivationMode.singleTap,
                        tooltipSettings: InteractiveTooltip(
                          color: cPrimary,
                        ),
                        lineColor: cPrimary,
                        lineWidth: 1.5,
                        lineDashArray: [5, 5],
                        markerSettings: TrackballMarkerSettings(
                          color: cPrimary,
                          borderColor: Colors.white,
                        ),
                        shouldAlwaysShow: true,
                      ),
                      plotAreaBorderColor: Colors.grey.shade50,
                      primaryXAxis: CategoryAxis(
                        axisLine: AxisLine(
                          color: cPrimary,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 10,
                        ),
                        majorTickLines: MajorTickLines(
                          size: 0,
                          width: 0,
                        ),
                      ),
                      primaryYAxis: NumericAxis(
                        axisLine: AxisLine(
                          color: cPrimary,
                        ),
                        minimum: 0,
                        majorTickLines: MajorTickLines(
                          size: 0,
                          width: 0,
                        ),
                        majorGridLines: MajorGridLines(width: 0),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      series: [
                        SplineAreaSeries<ChartData, String>(
                          onPointTap: (pointInteractionDetails) {
                            // final item = pointInteractionDetails
                            //     .dataPoints![pointInteractionDetails.pointIndex as int];
                          },
                          enableTooltip: true,
                          dataSource: state.items!.map((item) {
                            double value = 0;
                            String filter = filterKategori.toLowerCase();

                            if (filter == 'berat') {
                              value = item.berat;
                            } else if (filter == 'tinggi') {
                              value = item.tinggi;
                            } else if (filter == 'bmi') {
                              value = item.bmi;
                            } else if (filter == 'lemak tubuh') {
                              value = item.lemakTubuh;
                            }

                            return ChartData(
                              item.createdAt,
                              num.parse(value.toStringAsFixed(1)).toDouble(),
                            );
                          }).toList(),
                          xValueMapper: (data, _) => data.x,
                          yValueMapper: (data, _) => data.y,
                          borderWidth: 2,
                          borderColor: cPrimary,
                          gradient: LinearGradient(
                            colors: [
                              cPrimary.withOpacity(.1),
                              cPrimary.withOpacity(0),
                            ],
                            transform: GradientRotation(90),
                          ),
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            borderColor: cPrimary,
                            width: 10,
                            height: 10,
                          ),
                        )
                      ],
                    );
                  }

                  return Center(
                    child: Text('Terjadi kesalahan'),
                  );
                },
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Row(
                children: [
                  {
                    'label': 'Berat',
                    'icon': Icons.monitor_weight,
                  },
                  {
                    'label': 'Tinggi',
                    'icon': Icons.height,
                  },
                  {
                    'label': 'BMI',
                    'icon': Icons.card_membership,
                  },
                  {
                    'label': 'Lemak Tubuh',
                    'icon': Icons.pie_chart_outline_rounded,
                  },
                ]
                    .map((item) => boxPhillSelect(
                          icon: item['icon'] as IconData,
                          label: item['label'] as String,
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget boxPhillSelect({required IconData icon, required String label}) {
    bool isSelected = filterKategori == label;

    return InkWell(
      onTap: () {
        setState(() {
          filterKategori = label;
        });
      },
      child: Container(
        width: 130,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: isSelected ? Colors.white : null,
            border: Border(
              top: isSelected
                  ? BorderSide(
                      width: 2.5,
                      color: cPrimary,
                    )
                  : borderBase,
              left: borderBase.copyWith(color: Colors.grey.shade300),
              right: borderBase.copyWith(color: Colors.grey.shade300),
            )),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? cPrimary : Colors.grey.shade400,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget phillSelect({required String label}) {
    bool isSelected = label == filterWaktu;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            filterWaktu = label;
          });
          getReport();
        },
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? cPrimary : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/models/chartdata.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  String filterWaktu = 'Hari';
  String filterKategori = "Berat";

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
                children: [
                  phillSelect(label: 'Hari'),
                  phillSelect(label: 'Minggu'),
                  phillSelect(label: 'Bulan'),
                  phillSelect(label: 'Tahun'),
                ],
              ),
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: cPrimary,
                header: '',
                activationMode: ActivationMode.singleTap,
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
                  dataSource: [
                    ChartData('MEI', 49),
                    ChartData('JUN', 51),
                    ChartData('JUL', 44),
                  ],
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
                  boxPhillSelect(label: 'Berat', icon: Icons.monitor_weight),
                  boxPhillSelect(label: 'Tinggi', icon: Icons.height),
                  boxPhillSelect(label: 'BMI', icon: Icons.card_membership),
                  boxPhillSelect(
                      label: 'Lemak Tubuh',
                      icon: Icons.pie_chart_outline_rounded),
                ],
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

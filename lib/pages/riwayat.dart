import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
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
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  phillSelect(label: 'Hari', isSelected: true),
                  phillSelect(label: 'Minggu'),
                  phillSelect(label: 'Bulan'),
                  phillSelect(label: 'Tahun'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 800,
              padding: EdgeInsets.only(top: 20, right: 30),
              child: LineChart(mainData()),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: Colors.grey.withOpacity(.12),
              child: Row(
                children: [
                  boxPhillSelect(
                      label: 'Berat',
                      icon: Icons.monitor_weight,
                      isSelected: true),
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

  Container boxPhillSelect(
      {required IconData icon,
      required String label,
      bool isSelected = false}) {
    return Container(
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
                : BorderSide.none,
            left: BorderSide(
              width: 1,
              color: Colors.grey.shade300,
            ),
            right: BorderSide(
              width: 1,
              color: Colors.grey.shade300,
            ),
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
    );
  }

  Expanded phillSelect({bool isSelected = false, required String label}) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? cPrimary : null,
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      showingTooltipIndicators: [6]
          .map(
            (index) => ShowingTooltipIndicators(
              [
                LineBarSpot(
                  lineBarsData[0],
                  lineBarsData.indexOf(lineBarsData[0]),
                  lineBarsData[0].spots[index],
                )
              ],
            ),
          )
          .toList(),
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.pink,
          tooltipRoundedRadius: 4,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toString(),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(color: cPrimary.withOpacity(.7)),
          bottom: BorderSide(color: cPrimary.withOpacity(.7)),
        ),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: 150,
      lineBarsData: lineBarsData,
    );
  }

  final lineBarsData = [
    LineChartBarData(
      spots: const [
        FlSpot(0, 71),
        FlSpot(1, 66),
        FlSpot(2, 62),
        FlSpot(3, 60),
        FlSpot(4, 57),
        FlSpot(5, 64),
        FlSpot(6, 64),
      ],
      isCurved: true,
      gradient: LinearGradient(
        colors: [cPrimary, cPrimary],
      ),
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            cPrimary.withOpacity(0),
            cPrimary.withOpacity(.1),
          ],
        ),
      ),
    ),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontSize: 10,
      color: Colors.black,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = Text('MAR', style: style);
        break;
      case 5:
        text = Text('JUN', style: style);
        break;
      case 8:
        text = Text('SEP', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontSize: 10,
      color: cPrimary,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 150:
        text = '150';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vitalmetrics/bloc/data_realtime_bloc.dart';
import 'package:vitalmetrics/bloc/pengukuran_bloc.dart';
import 'package:vitalmetrics/bloc/perangkat_user_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/components/category_label.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/dates.dart';
import 'package:vitalmetrics/models/data_realtime.dart';
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
  PerangkatUserBloc perangkatBloc = PerangkatUserBloc();
  DataRealtimeBloc dataRealtimeBloc = DataRealtimeBloc();
  bool deviceIsOnline = true;
  DataRealtime? dataNow, dataLast;
  Timer? timer;

  @override
  void initState() {
    final userId = context.read<UserBloc>().state.id;
    pengukuranBloc.add(PengukuranGetLatest(userId: userId));
    perangkatBloc.add(PerangkatUserGetByUserId(userId: userId));

    super.initState();
  }

  checkStatusDevice(dynamic perangkatId) async {
    try {
      dataLast = dataNow;
      dataRealtimeBloc.add(DataRealtimeGetFirst(perangkatId: perangkatId));

      if (dataRealtimeBloc.state.item == null) {
        await Future.delayed(Duration(seconds: 1));
      }

      final res = dataRealtimeBloc.state.item;
      dataNow = res;

      await Future.delayed(Duration(seconds: 5));

      if (dataNow != null) {
        bool isOnline = DateTime.parse(dataNow!.createdAt).isAfter(
            dataLast != null
                ? DateTime.parse(dataLast!.createdAt)
                : DateTime.now());

        setState(() {
          deviceIsOnline = isOnline;
        });
      } else {
        setState(() {
          deviceIsOnline = false;
        });
      }
    } catch (e) {
      setState(() {
        deviceIsOnline = false;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    pengukuranBloc.close();
    perangkatBloc.close();
    dataRealtimeBloc.close();
    timer?.cancel();
    super.dispose();
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => pengukuranBloc,
          ),
          BlocProvider(
            create: (context) => perangkatBloc,
          ),
        ],
        child: BlocListener<PerangkatUserBloc, PerangkatUserState>(
          listener: (context, state) async {
            if (state.item != null) {
              timer = Timer.periodic(
                Duration(seconds: 5),
                (timer) async {
                  await checkStatusDevice(state.item!.id);
                },
              );
            }
          },
          child: BlocBuilder<PengukuranBloc, PengukuranState>(
            builder: (context, state) {
              Pengukuran dataTerakhir = Pengukuran(),
                  dataPembanding = Pengukuran();
              User user = context.read<UserBloc>().state.item ?? User();

              bool isEmpty = true, pembandingIsEmpty = true;

              if (state.items != null) {
                if (state.items!.isNotEmpty) {
                  isEmpty = false;
                  dataTerakhir = state.items?[0] ?? Pengukuran();

                  if (state.items!.length > 1) {
                    pembandingIsEmpty = false;
                    dataPembanding = state.items?[1] ?? Pengukuran();
                  }
                }
              }

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
                            child: !state.isLoading
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      !deviceIsOnline
                                          ? deviceOffline()
                                          : SizedBox(),
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
                                  )
                                : Center(
                                    child: BodyLoading(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
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
                                if (!isEmpty)
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          formatDateTime(
                                              dataTerakhir.createdAt),
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
                                    ],
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    perbandinganItem(
                                      label: 'BMI',
                                      value:
                                          dataTerakhir.bmi - dataPembanding.bmi,
                                    ),
                                    perbandinganItem(
                                      label: 'Skor Badan',
                                      value: dataTerakhir.skorBadan -
                                          dataPembanding.skorBadan,
                                    ),
                                    perbandinganItem(
                                      label: 'Lemak (%)',
                                      value: dataTerakhir.lemakTubuh -
                                          dataPembanding.lemakTubuh,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                if (!pembandingIsEmpty)
                                  Text(
                                    'Bandingkan dengan //${formatDateTime(dataPembanding.createdAt)}',
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
                                      result:
                                          dataTerakhir.bmi.toStringAsFixed(1),
                                      after: CategoryLabel(
                                        categories: getBmiCategory(),
                                        value: dataTerakhir.bmi,
                                      ),
                                    ),
                                    classificationItem(
                                      size,
                                      icon: Icons.sports_score,
                                      title: 'Skor badan',
                                      result: dataTerakhir.skorBadan
                                          .toStringAsFixed(1),
                                      after: CategoryLabel(
                                        categories: getSkorBadanCategory(),
                                        value: dataTerakhir.skorBadan,
                                      ),
                                    ),
                                    classificationItem(
                                      size,
                                      icon: Icons.pie_chart_outline_sharp,
                                      title: 'Lemak Tubuh',
                                      result:
                                          '${dataTerakhir.lemakTubuh.toStringAsFixed(1)}%',
                                      after: CategoryLabel(
                                        categories: getLemakTubuhCategory(
                                          gender: user.jenisKelamin,
                                        ),
                                        value: dataTerakhir.lemakTubuh,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: isEmpty
                                      ? Center(
                                          child: Text(
                                            'Anda belum melakukan pengukuran',
                                          ),
                                        )
                                      : FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: cPrimary,
                                            fixedSize:
                                                Size.fromWidth(size.width),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                '/report',
                                                arguments:
                                                    ReportArguments(id: ''));
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
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Container deviceOffline() {
    return Container(
      width: double.infinity,
      color: Colors.orange,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        'Device offline'.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Expanded perbandinganItem({
    required String label,
    required double value,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${value > 0 ? '+' : ''}${value.toStringAsFixed(1)}',
            style: TextStyle(
              color: cPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              value > 0
                  ? Icon(Icons.arrow_drop_up, color: Colors.green)
                  : Icon(Icons.arrow_drop_down, color: Colors.orange),
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
                // animationDuration: 0,
                value: value,
                color: Colors.white,
              ),
            ],
            markerPointers: [
              LinearShapePointer(
                // animationDuration: 0,
                value: value,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded classificationItem(
    Size size, {
    required IconData icon,
    required String result,
    required String title,
    Widget? after,
  }) {
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
              result,
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
            after ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}

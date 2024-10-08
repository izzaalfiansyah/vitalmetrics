import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vitalmetrics/bloc/data_realtime_bloc.dart';
import 'package:vitalmetrics/bloc/pengukuran_bloc.dart';
import 'package:vitalmetrics/bloc/perangkat_user_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/notif.dart';
import 'package:vitalmetrics/models/data_realtime.dart';
import 'package:vitalmetrics/models/pengukuran.dart';
import 'package:vitalmetrics/services/data_realtime_service.dart';

class UkurScreen extends StatefulWidget {
  const UkurScreen({super.key});

  @override
  State<UkurScreen> createState() => _UkurScreenState();
}

class _UkurScreenState extends State<UkurScreen> {
  DataRealtimeBloc dataRealtimeBloc = DataRealtimeBloc();
  PerangkatUserBloc perangkatUserBloc = PerangkatUserBloc();
  PengukuranBloc pengukuranBloc = PengukuranBloc();
  Timer? timer;
  int countdown = 0;

  @override
  void initState() {
    initMeasurement();

    final userId = context.read<UserBloc>().state.id;
    perangkatUserBloc.add(PerangkatUserGetByUserId(userId: userId));
    super.initState();
  }

  initMeasurement() {
    setState(() {
      countdown = 10;
    });
  }

  @override
  void dispose() {
    dataRealtimeBloc.close();
    perangkatUserBloc.close();
    timer?.cancel();
    super.dispose();
  }

  getRealtimeData() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        dataRealtimeBloc.add(DataRealtimeGetFirst(
          perangkatId: perangkatUserBloc.state.item!.id,
          withLoading: false,
        ));

        setState(() {
          countdown -= 1;
        });

        if (countdown <= 0) {
          timer.cancel();
        }
      },
    );
  }

  saveData(ctx) async {
    final user = context.read<UserBloc>().state.item!;
    final perangkat = perangkatUserBloc.state.item!;
    final data = dataRealtimeBloc.state.item!;

    final dataNow = await DataRealtimeService.first(perangkatId: perangkat.id);

    if (dataNow != null) {
      if (dataNow.berat > 5) {
        return notif(
          ctx,
          text: 'Silahkan beranjak dari alat terlebih dahulu',
        );
      }
    }

    pengukuranBloc.add(
      PengukuranInsert(
        item: Pengukuran(
          userId: user.id,
          perangkatId: perangkat.id,
          berat: data.berat,
          tinggi: data.tinggi,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Proses Pengukuran'),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          initMeasurement();
          getRealtimeData();
        },
        tooltip: 'Ukur ulang',
        child: Icon(
          Icons.refresh,
          color: cPrimary,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PerangkatUserBloc, PerangkatUserState>(
            bloc: perangkatUserBloc,
            listener: (context, state) {
              if (state.item != null) {
                getRealtimeData();
              }
            },
          ),
          BlocListener<PengukuranBloc, PengukuranState>(
            bloc: pengukuranBloc,
            listener: (context, state) {
              if (state.message != null) {
                notif(context, text: state.message!);

                if (!state.isError) {
                  Navigator.pop(context, 'reload');
                }
              }
            },
          ),
        ],
        child: BlocBuilder<PerangkatUserBloc, PerangkatUserState>(
          bloc: perangkatUserBloc,
          builder: (context, state) {
            if (state.isLoading) {
              return BodyLoading();
            }

            return BlocBuilder<DataRealtimeBloc, DataRealtimeState>(
              bloc: dataRealtimeBloc,
              builder: (context, state) {
                final dataRealtime = state.item ?? DataRealtime();

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // boxShadow: shadowBase,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(0),
                                child: SfRadialGauge(
                                  axes: [
                                    RadialAxis(
                                      minimum: 0,
                                      maximum: 200,
                                      annotations: [
                                        GaugeAnnotation(
                                          widget: Center(
                                            child: valueWidget(
                                              value: dataRealtime.berat
                                                  .toStringAsFixed(1),
                                              pcs: 'KG',
                                            ),
                                          ),
                                        )
                                      ],
                                      pointers: [
                                        RangePointer(
                                          value: dataRealtime.berat,
                                          color: cPrimary,
                                          enableAnimation: true,
                                        ),
                                        MarkerPointer(
                                          value: dataRealtime.berat,
                                          color: cPrimary,
                                          markerWidth: 15,
                                          markerHeight: 15,
                                          markerOffset: -10,
                                          enableAnimation: true,
                                        )
                                      ],
                                      showLastLabel: true,
                                      axisLineStyle: AxisLineStyle(
                                        color: Colors.grey.withOpacity(.2),
                                      ),
                                      showTicks: false,
                                      startAngle: 180,
                                      endAngle: 0,
                                      canScaleToFit: true,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // boxShadow: shadowBase,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 20),
                                    SfLinearGauge(
                                      minimum: 0,
                                      maximum: 300,
                                      interval: 100,
                                      axisTrackStyle: LinearAxisTrackStyle(
                                        thickness: 9,
                                        color: Colors.grey.withOpacity(.2),
                                      ),
                                      barPointers: [
                                        LinearBarPointer(
                                          value: dataRealtime.tinggi,
                                          thickness: 9,
                                          color: cPrimary,
                                          enableAnimation: true,
                                        )
                                      ],
                                      markerPointers: [
                                        LinearShapePointer(
                                          enableAnimation: true,
                                          value: dataRealtime.tinggi,
                                          color: cPrimary,
                                        ),
                                      ],
                                      showTicks: false,
                                    ),
                                    SizedBox(height: 14),
                                    valueWidget(
                                      pcs: 'CM',
                                      value: dataRealtime.tinggi
                                          .toStringAsFixed(1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        countdown <= 0
                            ? 'proses pengukuran telah selesai. silahkan segera beranjak dari alat.'
                            : 'Sedang melakukan proses pengukuran. silahkan berdiri tegak dan jangan beranjak dari alat.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      FilledButton(
                        onPressed: countdown <= 0
                            ? () {
                                saveData(context);
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: cPrimary,
                          fixedSize: Size.fromWidth(size.width),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(countdown <= 0
                            ? "SIMPAN"
                            : 'MEMUAT.... $countdown'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  RichText valueWidget({required String pcs, required String value}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 50,
            ),
          ),
          TextSpan(
            text: pcs,
          )
        ],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: cPrimary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vitalmetrics/bloc/pengukuran_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/category_label.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/dates.dart';
import 'package:vitalmetrics/models/pengukuran.dart';
import 'package:vitalmetrics/models/user.dart';

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
          User user = context.read<UserBloc>().state.item ?? User();

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
                            child: Column(
                              children: [
                                Text(
                                  'Skor Badan',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  height: 120,
                                  child: SfRadialGauge(
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
                                            value: dataTerakhir.skorBadan,
                                            color: Colors.white,
                                            enableAnimation: true,
                                            width: 5,
                                          ),
                                        ],
                                        annotations: [
                                          GaugeAnnotation(
                                            widget: Text(
                                              dataTerakhir.skorBadan
                                                  .toStringAsFixed(0),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 36,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
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
                                value: dataTerakhir.skorBadan -
                                    dataPembanding.skorBadan,
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
                ListTile(
                  title: Text(
                    'Komposisi Badan',
                    style: TextStyle(
                      color: cPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Hr(
                    // color: cPrimary,
                    ),
                Column(
                  children: [
                    ListItem(
                      label: "Berat",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.berat.toStringAsFixed(1)}kg',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "Tinggi",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.tinggi.toStringAsFixed(1)}cm',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "Skor Badan",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.skorBadan.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: CategoryLabel(
                              categories: getSkorBadanCategory(),
                              value: dataTerakhir.skorBadan,
                            ),
                          ),
                        ],
                      ),
                      after: Column(
                        children: [
                          CategoryLabel(
                            categories: getSkorBadanCategory(),
                            value: dataTerakhir.skorBadan,
                            graph: true,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc metus ipsum, mattis non ante dictum, finibus maximus magna. Sed feugiat nibh sem, eget hendrerit ante gravida quis. Donec est justo, faucibus sed odio ac, facilisis semper nibh. Vestibulum non fringilla lorem, eu vestibulum leo. Praesent venenatis enim egestas sapien tincidunt, eget tincidunt justo facilisis.',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "BMI",
                      trailing: Row(
                        children: [
                          Text(
                            dataTerakhir.bmi.toStringAsFixed(1),
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: CategoryLabel(
                              categories: getBmiCategory(),
                              value: dataTerakhir.bmi,
                            ),
                          ),
                        ],
                      ),
                      after: Column(
                        children: [
                          CategoryLabel(
                            categories: getBmiCategory(),
                            value: dataTerakhir.bmi,
                            graph: true,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc metus ipsum, mattis non ante dictum, finibus maximus magna. Sed feugiat nibh sem, eget hendrerit ante gravida quis. Donec est justo, faucibus sed odio ac, facilisis semper nibh. Vestibulum non fringilla lorem, eu vestibulum leo. Praesent venenatis enim egestas sapien tincidunt, eget tincidunt justo facilisis.',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "Lemak Tubuh",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.lemakTubuh.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            child: CategoryLabel(
                              categories: getLemakTubuhCategory(
                                  gender: user.jenisKelamin),
                              value: dataTerakhir.lemakTubuh,
                            ),
                          ),
                        ],
                      ),
                      after: Column(
                        children: [
                          CategoryLabel(
                            categories: getLemakTubuhCategory(),
                            value: dataTerakhir.lemakTubuh,
                            graph: true,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc metus ipsum, mattis non ante dictum, finibus maximus magna. Sed feugiat nibh sem, eget hendrerit ante gravida quis. Donec est justo, faucibus sed odio ac, facilisis semper nibh. Vestibulum non fringilla lorem, eu vestibulum leo. Praesent venenatis enim egestas sapien tincidunt, eget tincidunt justo facilisis.',
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "Air Dalam Tubuh",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.airDalamTubuh.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "Massa Otot Tubuh",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.massaOtotTubuh.toStringAsFixed(1)}kg',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "Massa Tulang",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.massaTulangPersentase.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListItem(
                      label: "Massa Protein",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.massaProteinPersentase.toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                  color: Colors.grey.shade200,
                ),
                ListTile(
                  title: Text(
                    'Manajemen Badan',
                    style: TextStyle(
                      color: cPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Hr(
                    // color: cPrimary,
                    ),
                Column(
                  children: [
                    ListItem(
                      label: "Berat Badan Ideal",
                      trailing: Row(
                        children: [
                          Text(
                            '${dataTerakhir.beratBadanIdeal.toStringAsFixed(1)}kg',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      fontSize: 24,
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

class ListItem extends StatefulWidget {
  const ListItem({super.key, this.after, this.trailing, required this.label});

  final Widget? after;
  final Widget? trailing;
  final String label;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.after != null
              ? () {
                  setState(() {
                    show = !show;
                  });
                }
              : null,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Text(widget.label)),
                widget.trailing ?? SizedBox(),
                widget.after != null
                    ? Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        Hr(),
        widget.after != null && show
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: widget.after,
                  ),
                  Hr(),
                ],
              )
            : SizedBox(),
      ],
    );
  }
}

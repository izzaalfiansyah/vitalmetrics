import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/perangkat_user_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';

class PerangkatKalibrasiBeratScreen extends StatefulWidget {
  const PerangkatKalibrasiBeratScreen({super.key});

  @override
  State<PerangkatKalibrasiBeratScreen> createState() =>
      _PerangkatKalibrasiBeratScreenState();
}

class _PerangkatKalibrasiBeratScreenState
    extends State<PerangkatKalibrasiBeratScreen> {
  PerangkatUserBloc perangkatUserBloc = PerangkatUserBloc();
  dynamic userId = '';
  bool on = false;
  int step = 1;
  int countdown = 0;

  @override
  void initState() {
    setState(() {
      userId = context.read<UserBloc>().state.item!.id;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perangkat Pengukur Berat'),
        leading: step == 1
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context, 'no-save');
                },
                icon: Icon(Icons.close),
              )
            : SizedBox(width: 0),
      ),
      body: BlocListener<PerangkatUserBloc, PerangkatUserState>(
        bloc: perangkatUserBloc,
        listener: (context, state) async {
          if (state.item != null && !on) {
            await perangkatUserBloc.kalibrasiBeratOn(state.item!.id);
            setState(() {
              on = true;
            });
          }
        },
        child: BlocBuilder<PerangkatUserBloc, PerangkatUserState>(
          bloc: perangkatUserBloc,
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: step == 1
                    ? step1()
                    : (step == 2 ? step2(state.item!) : step3(state, context)),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> step3(PerangkatUserState state, BuildContext context) {
    return [
      Text(
          'Kalibrasi Faktor: ${state.item?.kalibrasiBerat.toStringAsFixed(2) ?? 0} fac'),
      SizedBox(height: 20),
      FilledButton(
        onPressed: () {
          Navigator.of(context)
              .popUntil(ModalRoute.withName('/akun/perangkat'));
        },
        style: FilledButton.styleFrom(
          backgroundColor: cPrimary,
        ),
        child: Text('KONFIRMASI'),
      )
    ];
  }

  List<Widget> step2(PerangkatUser perangkat) {
    TextEditingController weight = TextEditingController();

    return [
      Text(
        'Berikan beban dengan berat yang sudah diketahui pada timbangan. Isikan berat beban pada isian berikut:',
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 10),
      TextField(
        controller: weight,
        decoration: InputDecoration(
          hintText: 'Masukkan berat beban',
          suffixText: 'gram',
        ),
        enabled: countdown > 5 ? false : true,
        keyboardType: TextInputType.number,
      ),
      SizedBox(height: 20),
      FilledButton(
        onPressed: countdown > 0
            ? null
            : () {
                perangkatUserBloc.updateKalibrasiBerat(
                    nomorSerial: perangkat.nomorSerial,
                    kalibrasiBerat: num.parse(weight.text).toDouble());

                setState(() {
                  countdown = 5;
                });

                Timer.periodic(
                  Duration(seconds: 1),
                  (timer) {
                    setState(() {
                      countdown -= 1;
                    });

                    if (countdown == 0) {
                      perangkatUserBloc
                          .add(PerangkatUserGetByUserId(userId: userId));
                      step += 1;
                      timer.cancel();
                    }
                  },
                );
              },
        style: FilledButton.styleFrom(
          backgroundColor: cPrimary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10),
            Text(countdown > 0 ? "Memuat... $countdown" : 'NEXT'),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward,
              size: 16,
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> step1() {
    return [
      Text(
        'Pastikan perangkat pengukur berat badan anda berada dalam kondisi kosong (tidak memiliki beban)!',
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      FilledButton(
        onPressed: countdown > 0
            ? null
            : () {
                perangkatUserBloc.add(PerangkatUserGetByUserId(userId: userId));
                setState(() {
                  countdown = 5;
                });

                Timer.periodic(
                  Duration(seconds: 1),
                  (timer) {
                    setState(() {
                      countdown -= 1;
                    });

                    if (countdown == 0) {
                      step += 1;
                      timer.cancel();
                    }
                  },
                );
              },
        style: FilledButton.styleFrom(
          backgroundColor: cPrimary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10),
            Text(countdown > 0 ? "Memuat... $countdown" : 'NEXT'),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward,
              size: 16,
            ),
          ],
        ),
      ),
    ];
  }
}

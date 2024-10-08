import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/perangkat_user_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/constant.dart';

class PerangkatKalibrasiTinggiScreen extends StatefulWidget {
  const PerangkatKalibrasiTinggiScreen({super.key});

  @override
  State<PerangkatKalibrasiTinggiScreen> createState() =>
      _PerangkatKalibrasiTinggiScreenState();
}

class _PerangkatKalibrasiTinggiScreenState
    extends State<PerangkatKalibrasiTinggiScreen> {
  PerangkatUserBloc perangkatUserBloc = PerangkatUserBloc();
  dynamic userId = '';
  int step = 1;
  int countdown = 0;
  bool on = false;

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
        title: Text('Perangkat Pengukur Tinggi'),
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
            await perangkatUserBloc.kalibrasiTinggiOn(state.item!.id);
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
                children: step == 1 ? step1() : step2(state, context),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> step2(PerangkatUserState state, BuildContext context) {
    return [
      Text(
          'Tinggi Perangkat: ${state.item?.kalibrasiTinggi.toStringAsFixed(2) ?? 0} cm'),
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

  List<Widget> step1() {
    return [
      Text(
        'Letakkan perangkat di tinggi yang anda tetapkan dan pastikan sensor menghadap lurus ke bawah!',
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
}

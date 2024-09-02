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
        listener: (context, state) {
          if (state.item != null) {
            setState(() {
              step = 2;
            });
          }
        },
        child: BlocBuilder<PerangkatUserBloc, PerangkatUserState>(
          bloc: perangkatUserBloc,
          builder: (context, state) {
            print(state.item);
            return Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: step == 1
                    ? [
                        Text(
                          'Letakkan perangkat di tinggi yang anda tetapkan dan pastikan sensor menghadap lurus ke bawah!',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        FilledButton(
                          onPressed: () {
                            perangkatUserBloc
                                .add(PerangkatUserGetByUserId(userId: userId));
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: cPrimary,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 10),
                              Text('NEXT'),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ]
                    : [
                        Text(
                            'Tinggi Perangkat: ${state.item?.kalibrasiTinggi.toStringAsFixed(2) ?? 0} cm'),
                        SizedBox(height: 20),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).popUntil(
                                ModalRoute.withName('/akun/perangkat'));
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: cPrimary,
                          ),
                          child: Text('KONFIRMASI'),
                        )
                      ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/perangkat_user_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';

class AkunPerangkatScreen extends StatefulWidget {
  const AkunPerangkatScreen({super.key});

  @override
  State<AkunPerangkatScreen> createState() => _AkunPerangkatScreenState();
}

class _AkunPerangkatScreenState extends State<AkunPerangkatScreen> {
  PerangkatUserBloc perangkatUserBloc = PerangkatUserBloc();
  dynamic userId;

  @override
  void initState() {
    setState(() {
      userId = context.read<UserBloc>().state.id;
    });
    perangkatUserBloc.add(PerangkatUserGetByUserId(userId: userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perangkat Saya'),
      ),
      body: BlocProvider(
        create: (context) => perangkatUserBloc,
        child: BlocListener<PerangkatUserBloc, PerangkatUserState>(
          listener: (context, state) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message.toString()),
                ),
              );
            }
          },
          child: BlocBuilder<PerangkatUserBloc, PerangkatUserState>(
            builder: (context, state) {
              if (state.isLoading) {
                return BodyLoading();
              }

              PerangkatUser? perangkat = state.item;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        perangkat != null
                            ? Container(
                                decoration: BoxDecoration(
                                  color: cPrimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: Icon(
                                  Icons.devices,
                                  color: Colors.white,
                                  size: 180,
                                ),
                              )
                            : Icon(
                                Icons.no_cell,
                                color: Colors.grey.shade300,
                                size: 180,
                              ),
                        SizedBox(height: 20),
                        Text(perangkat != null
                            ? 'Perangkat terhubung : ${perangkat.nomorSerial}'
                            : 'Tidak ada perangkat terhubung!')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: FilledButton(
                      onPressed: () {
                        if (perangkat != null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actionsPadding: EdgeInsets.only(bottom: 0),
                                content: Text(
                                    'Anda yakin memutuskan perangkat terhubung?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      perangkatUserBloc.add(
                                          PerangkatUserRemove(perangkat.id));
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              TextEditingController controller =
                                  TextEditingController();

                              return AlertDialog(
                                actionsPadding: EdgeInsets.only(bottom: 0),
                                content: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Nomor Serial',
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Nomor Serial wajib diisi';
                                    }
                                    return null;
                                  },
                                  controller: controller,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      perangkatUserBloc.add(
                                        PerangkatUserAdd(
                                          PerangkatUser(
                                            nomorSerial: controller.text,
                                            userId: userId,
                                          ),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: cPrimary,
                        fixedSize: Size.fromWidth(size.width),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        (perangkat != null
                                ? 'Putuskan Perangkat'
                                : 'Hubungkan Perangkat')
                            .toUpperCase(),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

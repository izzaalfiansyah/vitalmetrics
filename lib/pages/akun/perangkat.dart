import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/data_realtime_bloc.dart';
import 'package:vitalmetrics/bloc/perangkat_user_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/notif.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';

class AkunPerangkatScreen extends StatefulWidget {
  const AkunPerangkatScreen({super.key});

  @override
  State<AkunPerangkatScreen> createState() => _AkunPerangkatScreenState();
}

class _AkunPerangkatScreenState extends State<AkunPerangkatScreen> {
  PerangkatUserBloc perangkatUserBloc = PerangkatUserBloc();
  DataRealtimeBloc dataRealtimeBloc = DataRealtimeBloc();
  dynamic userId;

  tambahPerangkat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();

        return AlertDialog(
          actionsPadding: EdgeInsets.only(bottom: 0),
          content: TextFormField(
            decoration: InputDecoration(
              labelText: 'Nomor Serial',
              helperText: 'Perangkat pengukur berat badan',
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

  editNomorSerialTinggiBadan(BuildContext context, PerangkatUser perangkat) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(
          text: perangkat.nomorSerialTinggi,
        );

        return AlertDialog(
          actionsPadding: EdgeInsets.only(bottom: 0),
          content: TextFormField(
            decoration: InputDecoration(
              labelText: 'Nomor Serial',
              helperText: 'Perangkat pengukur tinggi badan',
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
                perangkat.nomorSerialTinggi = controller.text;
                perangkatUserBloc.add(
                  PerangkatUserUpdate(
                    perangkat,
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

  putuskanSemuaPerangkat(BuildContext context, PerangkatUser perangkat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(bottom: 0),
          content: Text('Anda yakin memutuskan semua perangkat terhubung?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                perangkatUserBloc.add(PerangkatUserRemove(perangkat.id));
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    setState(() {
      userId = context.read<UserBloc>().state.id;
    });
    perangkatUserBloc.add(PerangkatUserGetByUserId(userId: userId));
    super.initState();
  }

  @override
  void dispose() {
    perangkatUserBloc.close();
    dataRealtimeBloc.close();
    super.dispose();
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

            if (state.item != null) {
              dataRealtimeBloc
                  .add(DataRealtimeGetFirst(perangkatId: state.item!.id));
            }
          },
          child: BlocBuilder<PerangkatUserBloc, PerangkatUserState>(
            builder: (context, state) {
              if (state.isLoading) {
                return BodyLoading();
              }

              PerangkatUser? perangkat = state.item;

              if (perangkat == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.no_cell,
                            color: Colors.grey.shade300,
                            size: 180,
                          ),
                          SizedBox(height: 20),
                          // ESP-d83d627edc0c
                          Text('Tidak ada perangkat terhubung!')
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
                          tambahPerangkat(context);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: cPrimary,
                          fixedSize: Size.fromWidth(size.width),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Hubungkan Perangkat'.toUpperCase(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowBase,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Pengukur Berat Badan",
                                  style: TextStyle(
                                    color: cPrimary,
                                  ),
                                ),
                              ),
                              Hr(),
                              ListTile(
                                title: Text('Nomor Serial'),
                                subtitle: Text(
                                  perangkat.nomorSerial.toUpperCase(),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController controller =
                                          TextEditingController(
                                        text: perangkat.nomorSerial,
                                      );

                                      return AlertDialog(
                                        actionsPadding:
                                            EdgeInsets.only(bottom: 0),
                                        content: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Nomor Serial',
                                            helperText:
                                                'Perangkat pengukur berat badan',
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
                                              perangkat.nomorSerial =
                                                  controller.text;
                                              perangkatUserBloc.add(
                                                PerangkatUserUpdate(
                                                  perangkat,
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
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: shadowBase,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Pengukur Tinggi Badan',
                                  style: TextStyle(
                                    color: cPrimary,
                                  ),
                                ),
                                trailing: perangkat.nomorSerialTinggi != null
                                    ? IconButton(
                                        onPressed: () {
                                          perangkat.nomorSerialTinggi = null;
                                          perangkatUserBloc.add(
                                            PerangkatUserUpdate(
                                              perangkat,
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.grey.shade400,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          editNomorSerialTinggiBadan(
                                              context, perangkat);
                                        },
                                        icon: Icon(Icons.add),
                                        color: cPrimary,
                                      ),
                              ),
                              perangkat.nomorSerialTinggi != null
                                  ? Column(
                                      children: [
                                        Hr(),
                                        ListTile(
                                          title: Text('Nomor Serial'),
                                          subtitle: Text(
                                            perangkat.nomorSerialTinggi!,
                                            style: TextStyle(
                                              color:
                                                  perangkat.nomorSerialTinggi ==
                                                          null
                                                      ? Colors.grey.shade400
                                                      : null,
                                            ),
                                          ),
                                          onTap: () {
                                            editNomorSerialTinggiBadan(
                                                context, perangkat);
                                          },
                                        ),
                                        Hr(),
                                        ListTile(
                                          title: Text('Nilai Kalibrasi'),
                                          subtitle: Text(
                                              '${perangkat.kalibrasiTinggi.toStringAsFixed(2)} cm'),
                                          trailing: TextButton(
                                            onPressed: () async {
                                              final res = await Navigator.of(
                                                      context)
                                                  .pushNamed(
                                                      '/akun/perangkat/kalibrasi-tinggi');

                                              if (res != 'no-save') {
                                                await perangkatUserBloc
                                                    .kalibrasiTinggiOff(
                                                        perangkat.id);
                                                perangkatUserBloc.add(
                                                    PerangkatUserGetByUserId(
                                                        userId: userId));

                                                notif(context,
                                                    text:
                                                        "kalibrasi perangkat pengukur tinggi berhasil");
                                              }
                                            },
                                            child: Text('SET'),
                                          ),
                                        )
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Hr(),
                                        BlocBuilder<DataRealtimeBloc,
                                            DataRealtimeState>(
                                          bloc: dataRealtimeBloc,
                                          builder: (context, stateRealtime) {
                                            return ListTile(
                                              title: Text('Tinggi Badan'),
                                              subtitle: stateRealtime.isLoading
                                                  ? Text(
                                                      'Memuat...',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade400,
                                                      ),
                                                    )
                                                  : Text(
                                                      stateRealtime.item
                                                                  ?.tinggi !=
                                                              null
                                                          ? '${stateRealtime.item!.tinggi.toStringAsFixed(2)} cm'
                                                          : "Masukkan tinggi badan manual",
                                                      style: TextStyle(
                                                        color: stateRealtime
                                                                    .item ==
                                                                null
                                                            ? Colors
                                                                .grey.shade400
                                                            : null,
                                                      ),
                                                    ),
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    TextEditingController
                                                        controller =
                                                        TextEditingController(
                                                            text: stateRealtime
                                                                .item?.tinggi
                                                                .toStringAsFixed(
                                                                    2));

                                                    return AlertDialog(
                                                      actionsPadding:
                                                          EdgeInsets.only(
                                                              bottom: 0),
                                                      content: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Tinggi Badan',
                                                          helperText:
                                                              'Masukkan tinggi badan anda.',
                                                          suffixText: 'cm',
                                                        ),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Tinggi Badan wajib diisi';
                                                          }
                                                          return null;
                                                        },
                                                        controller: controller,
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            dataRealtimeBloc.add(DataRealtimeUpdateTinggi(
                                                                nomorSerial:
                                                                    perangkat
                                                                        .nomorSerial,
                                                                tinggi: num.parse(
                                                                        controller
                                                                            .text)
                                                                    .toDouble(),
                                                                perangkatId:
                                                                    perangkat
                                                                        .id));
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        )
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
                        putuskanSemuaPerangkat(context, perangkat);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: cPrimary,
                        fixedSize: Size.fromWidth(size.width),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Putuskan Perangkat'.toUpperCase(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

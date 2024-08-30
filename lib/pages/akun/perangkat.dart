import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/perangkat_user_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/hr.dart';
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
  bool isUsingHeightScale = false;

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
              setState(() {
                isUsingHeightScale = state.item?.nomorSerialTinggi != null;
              });
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
                                trailing: Switch.adaptive(
                                  applyCupertinoTheme: false,
                                  value: isUsingHeightScale,
                                  activeColor: cPrimary,
                                  trackOutlineWidth: WidgetStatePropertyAll(1),
                                  onChanged: (val) {
                                    setState(() {
                                      isUsingHeightScale = !isUsingHeightScale;
                                    });
                                  },
                                ),
                              ),
                              isUsingHeightScale
                                  ? Column(
                                      children: [
                                        Hr(),
                                        ListTile(
                                          title: Text('Nomor Serial'),
                                          subtitle: Text(
                                            perangkat.nomorSerialTinggi != null
                                                ? perangkat.nomorSerialTinggi!
                                                    .toUpperCase()
                                                : "Masukkan nomor perangkat",
                                            style: TextStyle(
                                              color:
                                                  perangkat.nomorSerialTinggi ==
                                                          null
                                                      ? Colors.grey.shade400
                                                      : null,
                                            ),
                                          ),
                                          trailing: perangkat
                                                      .nomorSerialTinggi !=
                                                  null
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  onPressed: () {
                                                    perangkat
                                                            .nomorSerialTinggi =
                                                        null;
                                                    perangkatUserBloc.add(
                                                      PerangkatUserUpdate(
                                                        perangkat,
                                                      ),
                                                    );
                                                  })
                                              : null,
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                TextEditingController
                                                    controller =
                                                    TextEditingController(
                                                  text: perangkat
                                                      .nomorSerialTinggi,
                                                );

                                                return AlertDialog(
                                                  actionsPadding:
                                                      EdgeInsets.only(
                                                          bottom: 0),
                                                  content: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Nomor Serial',
                                                      helperText:
                                                          'Perangkat pengukur tinggi badan',
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        perangkat
                                                                .nomorSerialTinggi =
                                                            controller.text;
                                                        perangkatUserBloc.add(
                                                          PerangkatUserUpdate(
                                                            perangkat,
                                                          ),
                                                        );
                                                        Navigator.of(context)
                                                            .pop();
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
                                    )
                                  : SizedBox(),
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actionsPadding: EdgeInsets.only(bottom: 0),
                              content: Text(
                                  'Anda yakin memutuskan semua perangkat terhubung?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    perangkatUserBloc
                                        .add(PerangkatUserRemove(perangkat.id));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
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

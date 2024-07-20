import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';
import 'package:vitalmetrics/services/perangkat_user.dart';

class AkunPerangkatScreen extends StatefulWidget {
  const AkunPerangkatScreen({super.key});

  @override
  State<AkunPerangkatScreen> createState() => _AkunPerangkatScreenState();
}

class _AkunPerangkatScreenState extends State<AkunPerangkatScreen> {
  PerangkatUser? perangkat;
  bool isLoading = true;

  @override
  void initState() {
    getPerangkat();
    super.initState();
  }

  getPerangkat() async {
    setState(() {
      isLoading = true;
    });

    final userId = await getUserId();
    final data = await PerangkatUserService.getByUserId(userId: userId);

    setState(() {
      if (data != null) {
        perangkat = data;
      } else {
        perangkat = null;
      }

      isLoading = false;
    });
  }

  savePerangkat(context, {required String nomorSerial}) async {
    final userId = await getUserId();
    PerangkatUser perangkatBaru =
        PerangkatUser(id: '', nomorSerial: nomorSerial, userId: userId);
    final data = await PerangkatUserService.create(perangkatBaru);

    if (data) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Perangkat berhasil dihubungkan.'),
        ),
      );

      await getPerangkat();
    }
  }

  removePerangkat(context) async {
    final data = await PerangkatUserService.delete(perangkat!.id);

    if (data) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Perangkat berhasil diputuskan.'),
        ),
      );

      await getPerangkat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perangkat Saya'),
      ),
      body: isLoading
          ? BodyLoading()
          : Column(
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
                              color: cPrimary,
                              size: 180,
                            ),
                      SizedBox(height: 10),
                      Text(perangkat != null
                          ? 'Perangkat terhubung : ${perangkat!.nomorSerial}'
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
                                    removePerangkat(context);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        dialogBuilder(
                          context,
                          label: 'Nomor Serial',
                          value: '',
                          onChange: (val) async {
                            savePerangkat(context, nomorSerial: val);
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
            ),
    );
  }

  Future<void> dialogBuilder(
    BuildContext context, {
    required String value,
    required String label,
    required Function(String) onChange,
  }) {
    TextEditingController controller = TextEditingController(text: value);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.only(bottom: 0),
          content: TextField(
            decoration: InputDecoration(
              labelText: label,
            ),
            controller: controller,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                onChange(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

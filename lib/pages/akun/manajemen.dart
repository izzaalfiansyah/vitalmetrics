import 'package:flutter/material.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/rumus.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/services/user.dart';

class AkunManajemenScreen extends StatefulWidget {
  const AkunManajemenScreen({super.key});

  @override
  State<AkunManajemenScreen> createState() => _AkunManajemenScreenState();
}

class _AkunManajemenScreenState extends State<AkunManajemenScreen> {
  User user = User();
  bool isLoading = true;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });

    final userId = await getUserId();
    final data = await UserService.find(userId);

    setState(() {
      user = data;
      isLoading = false;
    });
  }

  saveUser(context) async {
    final userId = await getUserId();
    final data = await UserService.update(userId, user);

    if (data) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Akun pengguna berhasil disimpan'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Pengguna'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => saveUser(context),
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? BodyLoading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: shadowBase,
                    ),
                    child: Column(
                      children: [
                        tileItem(
                          label: 'Username',
                          value: user.username,
                          onTap: () => dialogBuilder(context,
                              label: 'Username',
                              value: user.username, onChange: (val) {
                            setState(() {
                              user.username = val;
                            });
                          }),
                        ),
                        Hr(),
                        tileItem(
                          label: 'Password',
                          value: '*********',
                          onTap: () => dialogBuilder(context,
                              label: 'Password', value: '', onChange: (val) {
                            setState(() {
                              user.password = val;
                            });
                          }),
                        ),
                        Hr(),
                        tileItem(
                          label: 'Email',
                          value: user.email,
                          onTap: () => dialogBuilder(context,
                              label: 'Email',
                              value: user.email, onChange: (val) {
                            setState(() {
                              user.email = val;
                            });
                          }),
                        ),
                        Hr(),
                        tileItem(
                          label: 'Nama',
                          value: user.nama,
                          onTap: () => dialogBuilder(context,
                              label: 'Nama', value: user.nama, onChange: (val) {
                            setState(() {
                              user.nama = val;
                            });
                          }),
                        ),
                        Hr(),
                        tileItem(
                          label: 'Tanggal Lahir',
                          value: user.tanggalLahir,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(1970),
                              lastDate: DateTime.now(),
                              initialDate: DateTime.parse(user.tanggalLahir),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                            ).then((val) {
                              if (val != null) {
                                final tanggal = val.toString().substring(0, 10);
                                setState(() {
                                  user.tanggalLahir = tanggal;
                                });
                              }
                            });
                          },
                          trailing: Text(
                            '${getUmur(user.tanggalLahir)} tahun',
                            style: TextStyle(
                              color: cPrimary,
                            ),
                          ),
                        ),
                        Hr(),
                        tileItem(
                          label: 'Gender',
                          value: user.jenisKelamin == 'l'
                              ? 'Laki-laki'
                              : 'Perempuan',
                          onTap: () {
                            String groupValue = user.jenisKelamin;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: 10,
                                  ),
                                  actionsPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  title: Text(
                                    'Gender',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          {
                                            'value': 'l',
                                            'label': 'Laki-Laki',
                                          },
                                          {
                                            'value': 'p',
                                            'label': 'Perempuan',
                                          },
                                        ]
                                            .map(
                                              (item) => ListTile(
                                                title: Text(item['label']!),
                                                leading: Radio(
                                                  value: item['value'],
                                                  groupValue: groupValue,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      groupValue =
                                                          val.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      );
                                    },
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
                                        setState(() {
                                          user.jenisKelamin = groupValue;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  ListTile tileItem({
    required String label,
    required String value,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
      trailing: trailing,
      onTap: onTap,
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
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
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

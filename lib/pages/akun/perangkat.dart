import 'package:flutter/material.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/user_perangkat.dart';
import 'package:vitalmetrics/services/user_perangkat.dart';

class AkunPerangkatScreen extends StatefulWidget {
  const AkunPerangkatScreen({super.key});

  @override
  State<AkunPerangkatScreen> createState() => _AkunPerangkatScreenState();
}

class _AkunPerangkatScreenState extends State<AkunPerangkatScreen> {
  UserPerangkat perangkat = UserPerangkat(
    id: '',
    nomorSerial: '',
    userId: '',
  );

  @override
  void initState() {
    getPerangkat();
    super.initState();
  }

  getPerangkat() async {
    final userId = await getUserId();
    final data = await UserPerangkatService.getByUserId(userId: userId);

    setState(() {
      perangkat = data;
    });
  }

  savePerangkat(context) async {
    final data = await UserPerangkatService.update(perangkat.id, perangkat);

    if (data) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Perangkat berhasil disimpan'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perangkat Saya'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => savePerangkat(context),
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
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
                    label: 'Nomor Serial',
                    value: perangkat.nomorSerial,
                    onTap: () => dialogBuilder(context,
                        label: 'Nomor Serial',
                        value: perangkat.nomorSerial, onChange: (val) {
                      setState(() {
                        perangkat.nomorSerial = val;
                      });
                    }),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/menu_makanan_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/pages/menu/index.dart';

class WaktuMenu {
  final String title;
  final dynamic id;

  WaktuMenu({
    required this.title,
    required this.id,
  });
}

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({
    super.key,
    required this.category,
  });
  final MenuCategoryByAge category;

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  MenuMakananBloc menuMakananBloc = MenuMakananBloc();
  String kategoriGizi = 'normal';

  final waktuMenu = [
    WaktuMenu(title: 'Makan Pagi', id: '1'),
    WaktuMenu(title: 'Selingan Pagi', id: '2'),
    WaktuMenu(title: 'Makan Siang', id: '3'),
    WaktuMenu(title: 'Selingan Sore', id: '4'),
    WaktuMenu(title: 'Makan Malam', id: '5'),
  ];

  @override
  void initState() {
    menuMakananBloc.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu ${widget.category.label}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocProvider(
        create: (context) => menuMakananBloc,
        child: BlocBuilder<MenuMakananBloc, MenuMakananState>(
          builder: (context, state) {
            if (state.isLoading) {
              return BodyLoading();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: shadowBase,
                    ),
                    width: double.infinity,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: cPrimary,
                          ),
                        ),
                      ),
                      hint: Text('Pilih Kategori'),
                      value: kategoriGizi,
                      items: ['Normal', 'Kurang', 'Lebih'].map((item) {
                        return DropdownMenuItem(
                          value: item.toLowerCase(),
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          kategoriGizi = val!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: waktuMenu.length,
                    itemBuilder: (context, index) {
                      final item = waktuMenu[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowBase,
                            ),
                            margin: EdgeInsets.only(top: index == 0 ? 10 : 0),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title.toUpperCase(),
                                  style: TextStyle(
                                    color: cPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Hr(),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      List.generate(state.items!.length, (i) {
                                    final item = state.items![i];
                                    if (item.umurMax ==
                                            widget.category.umurMax &&
                                        item.umurMin ==
                                            widget.category.umurMin &&
                                        item.waktu == (index + 1).toString() &&
                                        item.kategoriGizi == kategoriGizi) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.nama,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                // border: TableBorder.all(
                                                //   color: Colors.grey.shade200,
                                                // ),
                                                border: TableBorder(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                  top: BorderSide(
                                                      color:
                                                          Colors.grey.shade200),
                                                ),
                                                dividerThickness: 0,
                                                headingRowHeight: 42,
                                                columns: [
                                                  DataColumn(
                                                      label: Text(
                                                    'Bahan'.toUpperCase(),
                                                    style: TextStyle(
                                                      color: cPrimary,
                                                    ),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    'Jumlah URT'.toUpperCase(),
                                                    style: TextStyle(
                                                      color: cPrimary,
                                                    ),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    'Berat (gram)'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: cPrimary,
                                                    ),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    'Energi (kkal)'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: cPrimary,
                                                    ),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    'Protein (gram)'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: cPrimary,
                                                    ),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    'Lemak (gram)'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: cPrimary,
                                                    ),
                                                  )),
                                                  DataColumn(
                                                      label: Text(
                                                    'KH (gram)'.toUpperCase(),
                                                    style: TextStyle(
                                                      color: cPrimary,
                                                    ),
                                                  )),
                                                ],
                                                rows: (item.bahan ?? [])
                                                    .map((bahan) {
                                                  return DataRow(cells: [
                                                    DataCell(Text(bahan.nama)),
                                                    DataCell(
                                                        Text(bahan.jumlahUrt)),
                                                    DataCell(
                                                      Text(bahan.berat
                                                          .toStringAsFixed(1)),
                                                    ),
                                                    DataCell(
                                                      Text(bahan.energi
                                                          .toStringAsFixed(1)),
                                                    ),
                                                    DataCell(
                                                      Text(bahan.protein
                                                          .toStringAsFixed(1)),
                                                    ),
                                                    DataCell(
                                                      Text(bahan.lemak
                                                          .toStringAsFixed(1)),
                                                    ),
                                                    DataCell(
                                                      Text(bahan.kh
                                                          .toStringAsFixed(1)),
                                                    ),
                                                  ]);
                                                }).toList(),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      );
                                    }

                                    return SizedBox();
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

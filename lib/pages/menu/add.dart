import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/menu_makanan_bloc.dart';
import 'package:vitalmetrics/components/form_group.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/models/menu_makanan.dart';
import 'package:vitalmetrics/pages/menu/index.dart';

class MenuAddScreen extends StatefulWidget {
  const MenuAddScreen({
    super.key,
    required this.kategoriUmur,
    required this.kategoriGizi,
    required this.menuMakananBloc,
  });

  final MenuCategoryByAge kategoriUmur;
  final String kategoriGizi;
  final MenuMakananBloc menuMakananBloc;

  @override
  State<MenuAddScreen> createState() => _MenuAddScreenState();
}

class _MenuAddScreenState extends State<MenuAddScreen> {
  String? kategoriGizi;
  final nama = TextEditingController();
  String? waktu;
  List<Bahan> bahan = [
    Bahan(),
  ];

  handleSave(BuildContext context) async {
    final menuMakanan = MenuMakanan(
      nama: nama.text,
      waktu: waktu.toString(),
      kategoriGizi: kategoriGizi.toString(),
      umurMin: widget.kategoriUmur.umurMin,
      umurMax: widget.kategoriUmur.umurMax,
      bahan: bahan,
    );

    widget.menuMakananBloc.store(menuMakanan);
  }

  @override
  void initState() {
    setState(() {
      kategoriGizi = widget.kategoriGizi;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Menu ${widget.kategoriUmur.label}'),
      ),
      body: BlocListener<MenuMakananBloc, MenuMakananState>(
        bloc: widget.menuMakananBloc,
        listener: (context, state) {
          if (state.message != null) {
            if (state.isError == false) {
              Navigator.pop(context, 1);
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                decoration:
                    BoxDecoration(color: Colors.white, boxShadow: shadowBase),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    FormGroup(
                      label: 'Kategori Gizi',
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
                    SizedBox(height: 20),
                    FormGroup(
                      label: 'Waktu',
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: Text('Pilih Waktu'),
                        value: waktu,
                        items: waktuMenu.map((item) {
                          return DropdownMenuItem(
                            value: item.id.toString(),
                            child: Text(item.title),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            waktu = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowBase,
                ),
                child: Column(
                  children: [
                    FormGroup(
                      label: 'Nama Menu',
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Masukkan Nama',
                        ),
                        controller: nama,
                      ),
                    ),
                    SizedBox(height: 20),
                    Hr(),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bahan.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            FormGroup(
                              label: 'Bahan ${index + 1}',
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nama Bahan',
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    bahan[index].nama = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: FormGroup(
                                    label: 'Jumlah URT',
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0 sdk',
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          bahan[index].jumlahUrt = val;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: FormGroup(
                                    label: 'Berat',
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0',
                                        suffixText: 'gram',
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          bahan[index].berat = num.parse(val);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: FormGroup(
                                    label: 'Energi',
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0',
                                        suffixText: 'kkal',
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          bahan[index].energi = num.parse(val);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: FormGroup(
                                    label: 'Protein',
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0',
                                        suffixText: 'gram',
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          bahan[index].protein = num.parse(val);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: FormGroup(
                                    label: 'Lemak',
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0',
                                        suffixText: 'gram',
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          bahan[index].lemak = num.parse(val);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: FormGroup(
                                    label: 'KH',
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '0',
                                        suffixText: 'gram',
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          bahan[index].kh = num.parse(val);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Hr(),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          bahan.add(Bahan());
                        });
                      },
                      style: FilledButton.styleFrom(
                        fixedSize: Size.fromWidth(size.width),
                        backgroundColor: Colors.black.withOpacity(.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('TAMBAH BAHAN'),
                    ),
                    FilledButton(
                      onPressed: () => handleSave(context),
                      style: FilledButton.styleFrom(
                        fixedSize: Size.fromWidth(size.width),
                        backgroundColor: cPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('SIMPAN MENU'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

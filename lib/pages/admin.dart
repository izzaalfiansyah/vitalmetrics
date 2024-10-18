import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/components/hr.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/services/user_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  UserCount userCount = UserCount();

  getCountUser() async {
    final res = await UserService.count();
    setState(() {
      userCount = res;
    });
  }

  @override
  void initState() {
    getCountUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Smart Record'.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/akun');
            },
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: size.height * 1 / 2,
              decoration: BoxDecoration(
                color: cPrimary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(60),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: shadowBase,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: cPrimary,
                          child: Text(
                            context.read<UserBloc>().state.item!.nama[0],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.read<UserBloc>().state.item!.nama,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Admin',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: shadowBase,
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cPrimary,
                          ),
                          child: Icon(
                            Icons.supervisor_account,
                            color: Colors.white,
                            size: 130,
                          ),
                        ),
                        SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: 'Total User: ',
                              ),
                              TextSpan(
                                text: userCount.total.toString(),
                                style: TextStyle(
                                  color: cPrimary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: shadowBase,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        containerGender(
                          icon: Icons.male,
                          color: Colors.cyan,
                          value: userCount.male.toString(),
                          label: 'Total Laki-Laki',
                        ),
                        SizedBox(height: 20),
                        Hr(),
                        SizedBox(height: 20),
                        containerGender(
                          icon: Icons.female,
                          color: Colors.orange,
                          value: userCount.female.toString(),
                          label: 'Total Perempuan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget containerGender({
    required Color color,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 75,
          width: 75,
          child: Icon(
            icon,
            color: Colors.white,
            size: 42,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

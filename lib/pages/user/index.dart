import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/user_bloc.dart';
import 'package:vitalmetrics/components/body_loading.dart';
import 'package:vitalmetrics/components/bottomnavbar.dart';
import 'package:vitalmetrics/constant.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/pages/user/detail.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserBloc userBloc = UserBloc();

  @override
  void initState() {
    userBloc.add(UserAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen User'),
        leading: SizedBox(),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return BodyLoading();
          }

          return ListView.builder(
            itemCount: state.items?.length ?? 0,
            itemBuilder: (context, index) {
              User user = state.items![index];

              return Column(
                children: [
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/user/detail',
                        arguments: UserDetailArgument(id: user.id),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadowBase,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: cPrimary,
                                child: Text(
                                  user.nama[0].toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.nama,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    user.email,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withOpacity(.5),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          // PopupMenuButton(
                          //   icon: Icon(
                          //     Icons.more_vert,
                          //     color: Colors.grey,
                          //   ),
                          //   itemBuilder: (context) {
                          //     return [
                          //       PopupMenuItem(
                          //         child: Text(
                          //           'Edit',
                          //         ),
                          //       ),
                          //       PopupMenuItem(
                          //         child: Text(
                          //           'Hapus',
                          //         ),
                          //       ),
                          //     ];
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

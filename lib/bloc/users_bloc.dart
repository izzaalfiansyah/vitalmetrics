import 'package:flutter_bloc/flutter_bloc.dart';

class UsersState {
  final String id;

  UsersState({
    this.id = '',
  });
}

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersState());
}

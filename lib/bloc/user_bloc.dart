import 'package:bloc/bloc.dart';
import 'package:vitalmetrics/bloc/state.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/services/user_service.dart';

class UserState extends AppState {
  dynamic id;
  User? item;
  List<User>? items;
  bool isLogin;

  UserState({
    this.id,
    this.item,
    this.items,
    this.isLogin = false,
    super.isLoading,
    super.isError,
    super.message,
  });
}

sealed class UserEvent {}

class UserGet extends UserEvent {}

class UserUpdate extends UserEvent {
  dynamic id;
  User user;

  UserUpdate(this.id, this.user);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGet>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      User user = await UserService.find();

      emit(UserState(
        id: user.id,
        item: user,
        isLoading: false,
        isLogin: true,
      ));
    });

    on<UserUpdate>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      final res = await UserService.update(event.id, event.user);
      final user = await UserService.find();

      if (res.success) {
        emit(UserState(
          message: res.message,
          item: user,
        ));
      } else {
        emit(UserState(
          isError: true,
          message: res.message,
          item: user,
        ));
      }
    });
  }
}

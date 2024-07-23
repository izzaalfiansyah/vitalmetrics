import 'package:bloc/bloc.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/services/type.dart';
import 'package:vitalmetrics/services/user_service.dart';

class UserState {
  dynamic id;
  User? item;
  List<User>? items;
  bool isLoading;
  bool isSaved;
  bool isLogin;
  bool isError;
  String? message;

  UserState({
    this.id,
    this.item,
    this.items,
    this.isLoading = false,
    this.isSaved = false,
    this.isLogin = false,
    this.isError = false,
    this.message,
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

      ServiceResponse res = await UserService.update(event.id, event.user);

      if (res.success) {
        emit(UserState(
          isLoading: false,
          message: res.message,
        ));
      } else {
        emit(UserState(
          isError: true,
          message: res.message,
        ));
      }
    });
  }
}

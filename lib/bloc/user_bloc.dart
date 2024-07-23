import 'package:bloc/bloc.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/services/user_service.dart';

class UserState {
  dynamic id;
  User? item;
  List<User>? items;
  bool isLoading;
  bool isSaved;
  bool isError;
  bool isLogin;

  UserState({
    this.id,
    this.item,
    this.items,
    this.isLoading = false,
    this.isSaved = false,
    this.isError = false,
    this.isLogin = false,
  });
}

sealed class UserEvent {}

class UserGetById extends UserEvent {
  String id;

  UserGetById(this.id);
}

class UserUpdate extends UserEvent {
  String id;
  User user;

  UserUpdate(this.id, this.user);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetById>((event, emit) async {
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

      bool saved = await UserService.update(event.id, event.user);

      if (saved) {
        emit(UserState(
          id: event.id,
          item: event.user,
          isLoading: false,
          isSaved: true,
        ));
      } else {
        emit(UserState(
          isError: true,
        ));
      }
    });
  }
}

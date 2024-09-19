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

class UserAll extends UserEvent {}

class UserGet extends UserEvent {}

class UserSet extends UserEvent {
  User? user;

  UserSet({this.user});
}

class UserFind extends UserEvent {
  dynamic id;

  UserFind(this.id);
}

class UserUpdate extends UserEvent {
  dynamic id;
  User user;

  UserUpdate(this.id, this.user);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserAll>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      List<User> users = await UserService.get();

      emit(UserState(
        items: users,
      ));
    });

    on<UserGet>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      User? user = await UserService.find();

      if (user != null) {
        emit(UserState(
          id: user.id,
          item: user,
          isLogin: true,
        ));
      } else {
        emit(UserState(
          isLogin: false,
        ));
      }
    });

    on<UserSet>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      User? user = event.user;

      if (user != null) {
        emit(UserState(
          id: user.id,
          item: user,
          isLogin: true,
        ));
      } else {
        emit(UserState(
          isLogin: false,
        ));
      }
    });

    on<UserFind>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      User? user = await UserService.find(id: event.id);

      emit(UserState(
        id: user?.id,
        item: user,
      ));
    });

    on<UserUpdate>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      final res = await UserService.update(event.id, event.user);
      final user = await UserService.find(id: event.id);

      emit(UserState(
        id: event.id,
        isError: !res.success,
        message: res.message,
        item: user,
      ));
    });
  }

  Future<User?> getUser() async {
    User? user = await UserService.find();
    add(UserSet(user: user));

    return user;
  }
}

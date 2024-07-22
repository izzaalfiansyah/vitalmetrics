import 'package:bloc/bloc.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/services/user_service.dart';

class UserState {
  String? id;
  User? item;
  List<User>? items;
  bool isLoading;
  bool isSaved;
  bool isError;

  UserState({
    this.id,
    this.item,
    this.items,
    this.isLoading = false,
    this.isSaved = false,
    this.isError = false,
  });
}

sealed class UserEvent {}

class UserEventGetById extends UserEvent {
  String id;

  UserEventGetById(this.id);
}

class UserEventUpdate extends UserEvent {
  String id;
  User user;

  UserEventUpdate(this.id, this.user);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserEventGetById>((event, emit) async {
      emit(UserState(
        isLoading: true,
      ));

      User user = await UserService.find(event.id);

      emit(UserState(
        id: event.id,
        item: user,
        isLoading: false,
      ));
    });

    on<UserEventUpdate>((event, emit) async {
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

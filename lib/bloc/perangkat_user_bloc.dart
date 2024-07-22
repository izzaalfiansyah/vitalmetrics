import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';
import 'package:vitalmetrics/services/perangkat_user_service.dart';

class PerangkatUserState {
  PerangkatUser? item;
  bool isLoading;
  bool isSaved;
  bool isRemoved;
  bool isError;

  PerangkatUserState({
    this.item,
    this.isLoading = false,
    this.isSaved = false,
    this.isRemoved = false,
    this.isError = false,
  });
}

class PerangkatUserEvent {}

class PerangkatUserGetByUserId extends PerangkatUserEvent {
  String userId;

  PerangkatUserGetByUserId({required this.userId});
}

class PerangkatUserAdd extends PerangkatUserEvent {
  PerangkatUser perangkat;

  PerangkatUserAdd(this.perangkat);
}

class PerangkatUserRemove extends PerangkatUserEvent {
  String id;

  PerangkatUserRemove(this.id);
}

class PerangkatUserBloc extends Bloc<PerangkatUserEvent, PerangkatUserState> {
  PerangkatUserBloc() : super(PerangkatUserState()) {
    on<PerangkatUserGetByUserId>((event, emit) async {
      emit(PerangkatUserState(
        isLoading: true,
      ));

      final userId = event.userId;

      final perangkat = await PerangkatUserService.getByUserId(userId: userId);

      emit(PerangkatUserState(
        item: perangkat,
        isLoading: false,
      ));
    });

    on<PerangkatUserAdd>((event, emit) async {
      emit(PerangkatUserState(
        isLoading: true,
      ));

      final isSaved = await PerangkatUserService.create(event.perangkat);
      final perangkat = await PerangkatUserService.getByUserId(
          userId: event.perangkat.userId);

      if (isSaved) {
        emit(PerangkatUserState(
          isLoading: false,
          isSaved: true,
          item: perangkat,
        ));
      } else {
        emit(PerangkatUserState(
          isLoading: false,
          isError: true,
        ));
      }
    });

    on<PerangkatUserRemove>((event, emit) async {
      emit(PerangkatUserState(
        isLoading: true,
      ));

      final isRemoved = await PerangkatUserService.delete(event.id);

      if (isRemoved) {
        emit(PerangkatUserState(
          isLoading: false,
          isRemoved: true,
          item: null,
        ));
      } else {
        emit(PerangkatUserState(
          isLoading: false,
          isError: true,
        ));
      }
    });
  }
}

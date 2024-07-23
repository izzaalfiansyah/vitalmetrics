import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/state.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';
import 'package:vitalmetrics/services/perangkat_user_service.dart';

class PerangkatUserState extends AppState {
  PerangkatUser? item;

  PerangkatUserState({
    this.item,
    super.isError,
    super.isLoading,
    super.message,
  });
}

class PerangkatUserEvent {}

class PerangkatUserGetByUserId extends PerangkatUserEvent {
  dynamic userId;

  PerangkatUserGetByUserId({required this.userId});
}

class PerangkatUserAdd extends PerangkatUserEvent {
  PerangkatUser perangkat;

  PerangkatUserAdd(this.perangkat);
}

class PerangkatUserRemove extends PerangkatUserEvent {
  dynamic id;

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
        isLoading: false,
        item: perangkat,
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
          item: perangkat,
        ));
      } else {
        emit(PerangkatUserState(
          isLoading: false,
          isError: true,
          item: perangkat,
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

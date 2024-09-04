import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/state.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
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

class PerangkatUserUpdate extends PerangkatUserEvent {
  PerangkatUser perangkat;

  PerangkatUserUpdate(this.perangkat);
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

      final res = await PerangkatUserService.create(event.perangkat);
      final perangkat = await PerangkatUserService.getByUserId(
          userId: event.perangkat.userId);

      emit(PerangkatUserState(
        item: perangkat,
        message: res.message,
        isError: !res.success,
      ));
    });

    on<PerangkatUserUpdate>((event, emit) async {
      emit(PerangkatUserState(
        isLoading: true,
      ));

      final res = await PerangkatUserService.update(
          event.perangkat.id, event.perangkat);
      final perangkat = await PerangkatUserService.getByUserId(
          userId: event.perangkat.userId);

      emit(PerangkatUserState(
        item: perangkat,
        message: res.message,
        isError: !res.success,
      ));
    });

    on<PerangkatUserRemove>((event, emit) async {
      emit(PerangkatUserState(
        isLoading: true,
      ));

      final res = await PerangkatUserService.delete(event.id);

      emit(PerangkatUserState(
        message: res.message,
        isError: !res.success,
      ));
    });
  }

  kalibrasiTinggiOn(dynamic id) async {
    String? token = await getToken();
    http(token).post("/perangkat_user/$id/kalibrasi_tinggi_on");
    return true;
  }

  kalibrasiTinggiOff(dynamic id) async {
    String? token = await getToken();
    http(token).post("/perangkat_user/$id/kalibrasi_tinggi_off");
    return true;
  }

  kalibrasiBeratOn(dynamic id) async {
    String? token = await getToken();
    http(token).post("/perangkat_user/$id/kalibrasi_berat_on");
    return true;
  }

  kalibrasiBeratOff(dynamic id) async {
    String? token = await getToken();
    http(token).post("/perangkat_user/$id/kalibrasi_berat_off");
    return true;
  }

  updateKalibrasiBerat({
    required String nomorSerial,
    required num kalibrasiBerat,
  }) async {
    await http(null).post("/perangkat_user/kalibrasi?tipe=berat", data: {
      'nomor_serial': nomorSerial,
      'kalibrasi_berat': kalibrasiBerat,
    });

    return true;
  }
}

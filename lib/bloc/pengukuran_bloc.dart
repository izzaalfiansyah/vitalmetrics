import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/state.dart';
import 'package:vitalmetrics/models/pengukuran.dart';
import 'package:vitalmetrics/services/pengukuran_service.dart';

class PengukuranState extends AppState {
  Pengukuran? item;
  List<Pengukuran>? items;

  PengukuranState({
    this.item,
    this.items,
    super.isLoading,
    super.isError,
    super.message,
  });
}

class PengukuranEvent {}

class PengukuranGetLatest extends PengukuranEvent {
  dynamic userId;

  PengukuranGetLatest({
    required this.userId,
  });
}

class PengukuranGetReport extends PengukuranEvent {
  dynamic userId;
  String tipe;

  PengukuranGetReport({
    required this.userId,
    this.tipe = 'harian',
  });
}

class PengukuranBloc extends Bloc<PengukuranEvent, PengukuranState> {
  PengukuranBloc() : super(PengukuranState()) {
    on<PengukuranGetLatest>((event, emit) async {
      emit(PengukuranState(
        isLoading: true,
      ));

      final pengukuran =
          await PengukuranService.getLatest(userId: event.userId);

      emit(PengukuranState(
        items: pengukuran,
      ));
    });

    on<PengukuranGetReport>((event, emit) async {
      emit(PengukuranState(
        isLoading: true,
      ));

      final pengukuran = await PengukuranService.getReport(
          userId: event.userId, tipe: event.tipe);

      emit(PengukuranState(
        items: pengukuran,
      ));
    });
  }
}

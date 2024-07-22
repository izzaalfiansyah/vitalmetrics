import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/models/pengukuran.dart';
import 'package:vitalmetrics/services/pengukuran_service.dart';

class PengukuranState {
  bool isLoading;
  Pengukuran? item;

  PengukuranState({
    this.isLoading = false,
    this.item,
  });
}

class PengukuranEvent {}

class PengukuranGetLatest extends PengukuranEvent {}

class PengukuranBloc extends Bloc<PengukuranEvent, PengukuranState> {
  PengukuranBloc() : super(PengukuranState()) {
    on<PengukuranGetLatest>((event, emit) async {
      emit(PengukuranState(
        isLoading: true,
      ));

      final pengukuran = await PengukuranService.getLatest();

      emit(PengukuranState(
        isLoading: false,
        item: pengukuran,
      ));
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/models/data_realtime.dart';
import 'package:vitalmetrics/services/data_realtime_service.dart';

class DataRealtimeState {
  final DataRealtime? item;
  final bool isLoading;

  DataRealtimeState({
    this.item,
    this.isLoading = false,
  });
}

sealed class DataRealtimeEvent {}

class DataRealtimeGetFirst extends DataRealtimeEvent {
  dynamic perangkatId;
  bool withLoading;

  DataRealtimeGetFirst({
    required this.perangkatId,
    this.withLoading = true,
  });
}

class DataRealtimeUpdateTinggi extends DataRealtimeEvent {
  dynamic perangkatId;
  String nomorSerial;
  double tinggi;

  DataRealtimeUpdateTinggi({
    required this.nomorSerial,
    required this.tinggi,
    required this.perangkatId,
  });
}

class DataRealtimeBloc extends Bloc<DataRealtimeEvent, DataRealtimeState> {
  DataRealtimeBloc() : super(DataRealtimeState()) {
    on<DataRealtimeGetFirst>((event, emit) async {
      if (event.withLoading) {
        emit(DataRealtimeState(isLoading: true));
      }

      final res =
          await DataRealtimeService.first(perangkatId: event.perangkatId);

      emit(DataRealtimeState(item: res));
    });

    on<DataRealtimeUpdateTinggi>((event, emit) async {
      emit(DataRealtimeState(isLoading: true));

      await DataRealtimeService.updateTinggi(
        nomorSerial: event.nomorSerial,
        tinggi: event.tinggi,
      );

      final res =
          await DataRealtimeService.first(perangkatId: event.perangkatId);

      emit(DataRealtimeState(item: res));
    });
  }
}

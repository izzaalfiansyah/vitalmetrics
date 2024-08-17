import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/state.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/menu_makanan.dart';

class MenuMakananState extends AppState {
  final List<MenuMakanan>? items;
  final MenuMakanan? item;

  MenuMakananState({
    super.isLoading,
    super.isError,
    super.message,
    this.items,
    this.item,
  });
}

class MenuMakananBloc extends Cubit<MenuMakananState> {
  MenuMakananBloc() : super(MenuMakananState());

  Future<void> get() async {
    emit(MenuMakananState(
      isLoading: true,
    ));
    try {
      final token = await getToken();
      final res = await http(token).get('/menu_makanan');

      List<MenuMakanan> data =
          List.from(res.data['data'].map((item) => MenuMakanan.fromJson(item)));

      emit(MenuMakananState(
        isLoading: false,
        items: data,
      ));
    } catch (e) {
      emit(MenuMakananState(
        isLoading: false,
        items: [],
      ));
    }
  }
}

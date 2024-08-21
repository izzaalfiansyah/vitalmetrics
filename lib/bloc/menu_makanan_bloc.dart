import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/bloc/state.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/menu_makanan.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/pages/menu/index.dart';

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

  Future<void> get({
    MenuCategoryByAge? categoryByAge,
    User? user,
  }) async {
    emit(MenuMakananState(
      isLoading: true,
    ));
    try {
      final token = await getToken();
      final res = await http(token).get('/menu_makanan', queryParameters: {
        'umur_min': categoryByAge?.umurMin ?? '',
        'umur_max': categoryByAge?.umurMax ?? '',
        'umur': user?.umur ?? '',
      });

      List<MenuMakanan> data =
          List.from(res.data['data'].map((item) => MenuMakanan.fromJson(item)));

      emit(MenuMakananState(
        items: data,
      ));
    } catch (e) {
      emit(MenuMakananState(
        items: [],
      ));
    }
  }

  Future<void> store(MenuMakanan menuMakanan) async {
    emit(MenuMakananState(isLoading: true));
    try {
      final token = await getToken();
      final res =
          await http(token).post('/menu_makanan', data: menuMakanan.toJson());

      emit(MenuMakananState(
        isError: !res.data['success'],
        message: res.data['message'],
      ));
    } on DioException catch (e) {
      emit(MenuMakananState(
        isError: true,
        message: e.response!.data['message'],
      ));
    } catch (e) {
      emit(MenuMakananState(
        isError: true,
        message: 'Terjadi kesalahan',
      ));
    }
  }

  Future<void> destroy(dynamic id) async {
    emit(MenuMakananState(isLoading: true));
    try {
      final token = await getToken();
      final res = await http(token).delete('/menu_makanan/$id');

      emit(MenuMakananState(
        isError: !res.data['success'],
        message: res.data['message'],
      ));
    } on DioException catch (e) {
      emit(MenuMakananState(
        isError: true,
        message: e.response!.data['message'],
      ));
    } catch (e) {
      emit(MenuMakananState(
        isError: true,
        message: 'Terjadi kesalahan',
      ));
    }
  }
}

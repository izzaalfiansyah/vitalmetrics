import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalmetrics/libs/http.dart';

class Data {
  String status;
  num min;
  String color;

  Data({
    required this.status,
    required this.min,
    this.color = 'green',
  });
}

class Category {
  List<Data> data;
  num max;
  num min;

  Category({
    required this.data,
    this.max = 100,
    this.min = 0,
  });

  factory Category.fromJSON(Map<String, dynamic> json) {
    return Category(
      data: List.from(
        json['data'].map<Data>(
          (data) {
            return Data(
              status: data['status'],
              min: data['min'],
              color: data['color'],
            );
          },
        ),
      ),
      max: json['max'] ?? 100,
      min: json['min'] ?? 100,
    );
  }
}

class CategoriesState {
  Category? bmi;
  Category? skorBadan;
  Category? lemakTubuhLaki;
  Category? lemakTubuhPerempuan;

  CategoriesState({
    this.bmi,
    this.skorBadan,
    this.lemakTubuhLaki,
    this.lemakTubuhPerempuan,
  });
}

class CategoriesEvent {}

class CategoriesSet extends CategoriesEvent {
  final CategoriesState state;

  CategoriesSet({required this.state});
}

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState()) {
    on<CategoriesSet>((event, emit) {
      emit(event.state);
    });
  }

  getAll() async {
    final res = await http(null).get('/categories');

    add(CategoriesSet(
      state: CategoriesState(
        bmi: Category.fromJSON(res.data['bmi']),
        skorBadan: Category.fromJSON(res.data['skor_badan']),
        lemakTubuhLaki: Category.fromJSON(res.data['lemak_tubuh_laki']),
        lemakTubuhPerempuan:
            Category.fromJSON(res.data['lemak_tubuh_perempuan']),
      ),
    ));
  }
}

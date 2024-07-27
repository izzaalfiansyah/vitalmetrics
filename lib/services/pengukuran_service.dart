import 'package:dio/dio.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/pengukuran.dart';
import 'package:vitalmetrics/services/type.dart';

class PengukuranService {
  static Future<List<Pengukuran>> getLatest({required dynamic userId}) async {
    try {
      final token = await getToken();
      final res = await http(token).get('/measurement?limit=2&user_id$userId');

      List<Pengukuran> data = List.from(
          res.data['data']['data'].map((item) => Pengukuran.fromJson(item)));
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Pengukuran>> getReport({
    dynamic userId,
    String? tipe,
  }) async {
    try {
      final token = await getToken();
      final res = await http(token)
          .get('/measurement/laporan?user_id=$userId&tipe=$tipe');

      List<Pengukuran> data =
          List.from(res.data['data'].map((item) => Pengukuran.fromJson(item)));

      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<ServiceResponse> insert({
    required Pengukuran pengukuran,
  }) async {
    try {
      final token = await getToken();
      final res =
          await http(token).post('/measurement', data: pengukuran.toJSON());

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response?.data);
    } catch (e) {
      return ServiceResponse(success: false, message: "Terjadi kesalahan");
    }
  }

  static Future<ServiceResponse> remove({
    required dynamic id,
  }) async {
    try {
      final token = await getToken();
      final res = await http(token).delete('/measurement/$id');
      print(res.realUri.toString());

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response?.data);
    } catch (e) {
      return ServiceResponse(success: false, message: "Terjadi kesalahan");
    }
  }
}

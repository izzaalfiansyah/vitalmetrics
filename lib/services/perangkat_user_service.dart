import 'package:dio/dio.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';
import 'package:vitalmetrics/services/type.dart';

class PerangkatUserService {
  static Future<PerangkatUser?> getByUserId({required dynamic userId}) async {
    try {
      final token = await getToken();
      final res = await http(token).get('/perangkat_user/by_user_id/$userId');

      final perangkat = PerangkatUser.fromJson(res.data['data']);

      return perangkat;
    } catch (e) {
      return null;
    }
  }

  static Future<ServiceResponse> create(PerangkatUser perangkat) async {
    try {
      final token = await getToken();
      final res =
          await http(token).post('/perangkat_user', data: perangkat.toJson());

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response?.data);
    } catch (e) {
      return ServiceResponse(success: false, message: 'Terjadi kesalahan');
    }
  }

  static Future<ServiceResponse> delete(dynamic id) async {
    try {
      final token = await getToken();
      final res = await http(token).delete('/perangkat_user/$id');

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response?.data);
    } catch (e) {
      return ServiceResponse(success: false, message: 'Terjadi kesalahan');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/services/type.dart';

class UserService {
  static Future<List<User>> get() async {
    final token = await getToken();
    final res = await http(token).get('/users');
    final data = res.data['data'];

    List<User> items = data.map((item) => User.fromJson(item));

    return items;
  }

  static Future<User> find() async {
    final token = await getToken();
    final res = await http(token).get('/user');

    User item = User.fromJson(res.data);

    return item;
  }

  static Future<ServiceResponse> update(dynamic id, User user) async {
    try {
      final token = await getToken();
      final res = await http(token).put('/users/$id', data: user.toJson());

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response?.data);
    } catch (e) {
      return ServiceResponse(success: false, message: 'terjadi kesalahan');
    }
  }
}

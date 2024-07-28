import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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

  static Future<User?> find() async {
    try {
      final token = await getToken();
      final res = await http(token).get('/user');

      User item = User.fromJson(res.data);

      return item;
    } catch (e) {
      return null;
    }
  }

  static Future<ServiceResponse> update(dynamic id, User user) async {
    try {
      final token = await getToken();
      final res = await http(token).put('/users/$id', data: user.toJson());

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response?.data);
    } catch (e) {
      return ServiceResponse(success: false, message: 'Yerjadi kesalahan');
    }
  }

  static Future<ServiceResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      String deviceName = '';

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.utsname.machine;
      } else {
        deviceName = 'Other';
      }

      final res = await http(null).post('/sanctum/token', data: {
        'username': username,
        'password': password,
        'device_name': deviceName,
      });

      String? token = res.data['token'];

      if (token != null && token != '') {
        setToken(token);
      }

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response!.data);
    } catch (e) {
      return ServiceResponse(success: false, message: 'Terjadi kesalahan');
    }
  }
}

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/user.dart';
import 'package:vitalmetrics/services/type.dart';

class UserCount {
  final int total;
  final int male;
  final int female;

  UserCount({
    this.total = 0,
    this.male = 0,
    this.female = 0,
  });
}

class UserService {
  static Future<List<User>> get() async {
    try {
      final token = await getToken();
      final res = await http(token).get('/users');
      final data = res.data['data']['data'];

      List<User> items = List.from(data.map((item) => User.fromJson(item)));

      return items;
    } catch (e) {
      return [];
    }
  }

  static Future<UserCount> count() async {
    try {
      final token = await getToken();
      final res = await http(token).get('/users/count');
      final data = res.data['data'];

      return UserCount(
        total: data['total'],
        male: data['male'],
        female: data['female'],
      );
    } catch (e) {
      return UserCount();
    }
  }

  static Future<User?> find({id}) async {
    try {
      final token = await getToken();

      if (id != null) {
        final res = await http(token).get('/users/$id');

        User item = User.fromJson(res.data['data']);

        return item;
      }

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

      final res = await http(null).post('/login', data: {
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

  static Future<ServiceResponse> register(User user) async {
    try {
      final res = await http(null).post('/register', data: user.toJson());

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response!.data);
    } catch (e) {
      return ServiceResponse(success: false, message: 'Terjadi kesalahan');
    }
  }

  static Future<ServiceResponse> logout() async {
    try {
      final token = await getToken();
      final res = await http(token).post('/logout');

      return ServiceResponse.fromJson(res.data);
    } on DioException catch (e) {
      return ServiceResponse.fromJson(e.response!.data);
    } catch (e) {
      return ServiceResponse(success: false, message: 'Terjadi kesalahan');
    }
  }
}

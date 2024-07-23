import 'dart:convert';

import 'package:http/http.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';

class PerangkatUserService {
  static String url = '$apiUrlDebug/perangkat_user';
  static Client client = Client();

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

  static Future<bool> create(PerangkatUser perangkat) async {
    final data = jsonEncode(perangkat.toJson());
    final response = await client.post(Uri.parse(url), body: data);

    return response.statusCode < 400;
  }

  static Future<bool> update(dynamic id, PerangkatUser perangkat) async {
    final data = jsonEncode(perangkat.toJson());
    final response = await client.put(Uri.parse('$url/$id'), body: data);

    return response.statusCode < 400;
  }

  static Future<bool> delete(dynamic id) async {
    final response = await client.delete(Uri.parse('$url/$id'));

    return response.statusCode < 400;
  }
}

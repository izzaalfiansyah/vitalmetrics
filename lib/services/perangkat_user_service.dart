import 'dart:convert';

import 'package:http/http.dart';
import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/models/perangkat_user.dart';

class PerangkatUserService {
  static String url = '$apiUrlDebug/perangkat_user';
  static Client client = Client();

  static Future<PerangkatUser?> getByUserId({required String userId}) async {
    final response = await client.get(Uri.parse('$url?user_id=$userId'));
    final data = jsonDecode(response.body);

    if (data.length > 0) {
      final item = PerangkatUser.fromJson(data[0]);

      return item;
    }

    return null;
  }

  static Future<bool> create(PerangkatUser perangkat) async {
    final data = jsonEncode(perangkat.toJson());
    final response = await client.post(Uri.parse(url), body: data);

    return response.statusCode < 400;
  }

  static Future<bool> update(String id, PerangkatUser perangkat) async {
    final data = jsonEncode(perangkat.toJson());
    final response = await client.put(Uri.parse('$url/$id'), body: data);

    return response.statusCode < 400;
  }

  static Future<bool> delete(String id) async {
    final response = await client.delete(Uri.parse('$url/$id'));

    return response.statusCode < 400;
  }
}

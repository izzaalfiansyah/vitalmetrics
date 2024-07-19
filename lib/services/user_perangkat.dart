import 'dart:convert';

import 'package:http/http.dart';
import 'package:vitalmetrics/libs/api.dart';
import 'package:vitalmetrics/models/user_perangkat.dart';

class UserPerangkatService {
  static String url = '$apiUrl/perangkat_user';
  static Client client = Client();

  static Future<UserPerangkat> getByUserId({required String userId}) async {
    final response = await client.get(Uri.parse('$url?user_id=$userId'));
    final data = jsonDecode(response.body);

    final item = UserPerangkat.fromJson(data[0]);

    return item;
  }

  static Future<bool> update(String id, UserPerangkat perangkat) async {
    final data = jsonEncode(perangkat.toJson());
    await client.put(Uri.parse('$url/$id'), body: data);

    return true;
  }
}

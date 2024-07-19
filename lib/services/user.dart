import 'dart:convert';

import 'package:http/http.dart';
import 'package:vitalmetrics/libs/api.dart';
import 'package:vitalmetrics/models/user.dart';

class UserService {
  static String url = '$apiUrl/user';
  static Client client = Client();

  static Future<List<User>> get() async {
    final response = await client.get(Uri.parse('$url/'));
    final data = jsonDecode(response.body);
    print(data);

    List<User> items = data.map((item) => User.fromJson(item));

    return items;
  }

  static Future<User> find(String id) async {
    final response = await client.get(Uri.parse('$url/$id'));
    final data = jsonDecode(response.body);

    User item = User.fromJson(data);

    return item;
  }

  static Future<bool> update(String id, User user) async {
    final body = jsonEncode(user.toJson());
    await client.put(Uri.parse('$url/$id'), body: body);

    return true;
  }
}

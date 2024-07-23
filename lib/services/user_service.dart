import 'dart:convert';
import 'package:http/http.dart';
import 'package:vitalmetrics/libs/api.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/user.dart';

class UserService {
  static String url = '$apiUrlDebug/user';
  static Client client = Client();

  static Future<List<User>> get() async {
    final response = await client.get(Uri.parse('$url/'));
    final data = jsonDecode(response.body);

    List<User> items = data.map((item) => User.fromJson(item));

    return items;
  }

  static Future<User> find() async {
    final token = await getToken();
    final res = await http(token).get('/user');

    User item = User.fromJson(res.data);

    return item;
  }

  static Future<bool> update(String id, User user) async {
    final body = jsonEncode(user.toJson());
    final response = await client.put(Uri.parse('$url/$id'), body: body);

    return response.statusCode == 200;
  }
}

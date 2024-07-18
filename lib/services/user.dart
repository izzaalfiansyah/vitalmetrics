import 'dart:convert';

import 'package:http/http.dart';
import 'package:vitalmetrics/libs/api.dart';
import 'package:vitalmetrics/models/user.dart';

class UserService {
  final String url = '$apiUrl/user';
  Client client = Client();

  get() async {
    final response = await client.get(Uri.parse('$url/'));
    final data = jsonDecode(response.body);
    print(data);

    List<User> items = data.map((item) => User.fromJson(item));

    return items;
  }

  find(String id) async {
    final response = await client.get(Uri.parse('$url/$id'));
    final data = jsonDecode(response.body);

    User item = User.fromJson(data);

    return item;
  }
}
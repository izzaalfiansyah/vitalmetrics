import 'package:shared_preferences/shared_preferences.dart';

setUserId(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', id);
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? id = prefs.getString('userId');

  return id ?? '';
}

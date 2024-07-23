import 'dart:convert';

import 'package:http/http.dart';
import 'package:vitalmetrics/libs/api.dart';
import 'package:vitalmetrics/models/pengukuran.dart';

class PengukuranService {
  static String url = '$apiUrlDebug/data_pengukuran';
  static Client client = Client();

  static Future<List<Pengukuran>> getLatest() async {
    final response =
        await client.get(Uri.parse('$url?_sort=-created_at&_limit=2'));
    final data = jsonDecode(response.body);

    final items =
        List<Pengukuran>.from(data.map((item) => Pengukuran.fromJson(item)));

    return items;
  }
}

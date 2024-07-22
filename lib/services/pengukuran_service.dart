import 'dart:convert';

import 'package:http/http.dart';
import 'package:vitalmetrics/libs/api.dart';
import 'package:vitalmetrics/models/pengukuran.dart';

class PengukuranService {
  static String url = '$apiUrl/data_pengukuran';
  static Client http = Client();

  static Future<Pengukuran?> getLatest() async {
    final response =
        await http.get(Uri.parse('$url?_sort=-created_at&_limit=1'));
    final data = jsonDecode(response.body);
    final pengukuran = Pengukuran.fromJSON(data[0]);

    return pengukuran;
  }
}

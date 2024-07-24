import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/pengukuran.dart';

class PengukuranService {
  static Future<List<Pengukuran>> getLatest({required dynamic userId}) async {
    try {
      final token = await getToken();
      final res = await http(token).get('/measurement?limit=2&user_id$userId');

      List<Pengukuran> data = List.from(
          res.data['data']['data'].map((item) => Pengukuran.fromJson(item)));
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Pengukuran>> getReport({
    dynamic userId,
    String? tipe,
  }) async {
    try {
      final token = await getToken();
      final res = await http(token)
          .get('/measurement/laporan?user_id=$userId&tipe=$tipe');

      List<Pengukuran> data =
          List.from(res.data['data'].map((item) => Pengukuran.fromJson(item)));

      return data;
    } catch (e) {
      return [];
    }
  }
}

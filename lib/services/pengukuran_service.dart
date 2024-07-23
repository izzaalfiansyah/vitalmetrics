import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/pengukuran.dart';

class PengukuranService {
  static Future<List<Pengukuran>> getLatest({required dynamic userId}) async {
    try {
      final token = await getToken();
      final res =
          await http(token).get('/measurement/by_user_id/$userId/latest');

      List<Pengukuran> data =
          List.from(res.data['data'].map((item) => Pengukuran.fromJson(item)));
      return data;
    } catch (e) {
      return [];
    }
  }
}

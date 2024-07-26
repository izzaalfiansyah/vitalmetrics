import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/data_realtime.dart';

class DataRealtimeService {
  static Future<DataRealtime?> first({required dynamic perangkatId}) async {
    try {
      final token = await getToken();
      final res =
          await http(token).get('/realtime/by_perangkat_id/$perangkatId');
      DataRealtime data = DataRealtime.fromJson(res.data['data']);

      return data;
    } catch (e) {
      return null;
    }
  }
}

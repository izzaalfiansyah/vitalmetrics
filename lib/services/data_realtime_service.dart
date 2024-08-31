import 'package:vitalmetrics/libs/http.dart';
import 'package:vitalmetrics/libs/session.dart';
import 'package:vitalmetrics/models/data_realtime.dart';
import 'package:vitalmetrics/services/type.dart';

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

  static Future<ServiceResponse> updateTinggi(
      {required String nomorSerial, required double tinggi}) async {
    try {
      final token = await getToken();
      final res = await http(token).post('/realtime', data: {
        'nomor_serial': nomorSerial,
        'tinggi': tinggi,
        'tipe': 'tinggi',
      });

      return ServiceResponse.fromJson(res.data);
    } catch (e) {
      return ServiceResponse(success: false, message: "Terjadi kesalahan");
    }
  }
}

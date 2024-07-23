import 'package:dio/dio.dart';

const String apiUrlDebug = 'http://10.0.2.2:3000';

Dio http(String? token) {
  final options = BaseOptions(baseUrl: 'http://10.0.2.2:8000/api', headers: {
    'Accept': 'application/json',
    'Authorization': token != null ? 'Bearer $token' : '',
  });

  Dio dio = Dio(options);
  return dio;
}

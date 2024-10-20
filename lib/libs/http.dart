import 'package:dio/dio.dart';

// const String apiUrl = 'http://localhost:8000/api'; // development
const String apiUrl = 'https://penelitian.pnbpproject.my.id/api'; // production

Dio http(String? token) {
  final options = BaseOptions(baseUrl: apiUrl, headers: {
    'Accept': 'application/json',
    'Authorization': token != null ? 'Bearer $token' : '',
    'Access-Control-Allow-Credentials': true,
  });

  Dio dio = Dio(options);
  return dio;
}

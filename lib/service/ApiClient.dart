import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(BaseOptions(
    //Home
    baseUrl: 'http://192.168.18.6:5000/',
    //Phone
     //baseUrl: 'http://192.168.75.147:5000/',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 15),
  ));

  Dio get dio => _dio;

  ApiClient() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}

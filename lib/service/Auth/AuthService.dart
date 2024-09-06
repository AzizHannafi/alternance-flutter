import 'package:alternance_flutter/service/ApiClient.dart';
import 'package:dio/dio.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<String?> loginUser(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/users/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        return token;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      return null;
    }
  }
}

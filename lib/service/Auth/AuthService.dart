import 'dart:convert';

import 'package:alternance_flutter/service/ApiClient.dart';
import 'package:dio/dio.dart';
import 'package:alternance_flutter/utils/JwtUtils.dart';

import '../../model/user/RegisterDto.dart';

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
        JwtUtils.decodeToken(token);
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

  Future<Map<String, dynamic>> registerUser(RegisterDto registerDto) async {
    try {
      String endpoint;
      switch (registerDto.role) {
        case 'student':
          endpoint = '/api/students';
          break;
        case 'company':
          endpoint = '/api/companies';
          break;
        case 'university':
          endpoint = '/api/universities';
          break;
        default:
          throw Exception('Invalid role');
      }

      print('Sending request to: $endpoint');
      print('Request Data: ${jsonEncode(registerDto.toJson())}');

      final response = await _apiClient.dio.post(
        endpoint,
        data: registerDto.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        JwtUtils.decodeToken(token);
        return {
          'success': true,
          'token': token,
          'user': response.data['user'],
          'message': response.data['message'] ?? 'Registration successful',
        };
      } else {
        print('Unexpected status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        return {
          'success': false,
          'message': 'Registration failed: ${response.statusMessage}',
        };
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException type: ${e.type}');
      print('DioException response: ${e.response?.data}');
      return {
        'success': false,
        'message': 'Registration failed: ${e.message}',
      };
    }
  }
}

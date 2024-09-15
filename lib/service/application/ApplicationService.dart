import 'package:alternance_flutter/model/Application.dart';
import 'package:alternance_flutter/model/ApplicationDto.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class Applicationservice {
  final ApiClient _apiClient = ApiClient();

  Future<List<Application>> fetchApplicationById(int studentId) async {
    try {
      final response =
          await _apiClient.dio.get("/api/applications/st/$studentId");

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;

        // Manually map the response data to a list of Education objects
        return data.map((json) => Application.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Applications');
      }
    } catch (e) {
      throw Exception('Failed to load Applications: $e');
    }
  }

  Future<List<ApplicationDto>> fetchApplicationByStudent(int studentId) async {
    try {
      final response =
          await _apiClient.dio.get("/api/applications/student/$studentId");

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;

        // Manually map the response data to a list of Education objects
        return data.map((json) => ApplicationDto.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Applications');
      }
    } catch (e) {
      print('***************************$e');
      throw Exception('Failed to load Applications: $e');
    }
  }
}

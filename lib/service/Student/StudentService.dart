import 'package:alternance_flutter/model/Offers.dart';
import 'package:alternance_flutter/model/Student.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class Studentservice {
  final ApiClient _apiClient = ApiClient();

  Future<Student> fetchProfile(int userId) async {
    try {
      final response = await _apiClient.dio.get("/api/students/user/$userId");

      if (response.statusCode == 200) {
        // Manually map the response data to the Profile model
        return Student.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
}

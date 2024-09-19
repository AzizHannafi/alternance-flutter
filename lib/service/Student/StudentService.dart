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

  Future<Student> updateProfile(int studentId, Student updatedStudent) async {
    try {
      // Convert the updated student to JSON
      final studentJson = updatedStudent.toJson();

      // Make the PUT request and pass the student data as the body
      final response = await _apiClient.dio.put(
        "/api/students/$studentId",
        data: studentJson, // Pass the student data in the request body
      );

      if (response.statusCode == 200) {
        return Student.fromJson(response.data["updatedStudent"]);
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<List<Student>> fetchStudent() async {
    try {
      final response = await _apiClient.dio.get("/api/students");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        return data.map((studentJson) => Student.fromJson(studentJson)).toList();

      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      throw Exception('Failed to load students: $e');
    }
  }
}

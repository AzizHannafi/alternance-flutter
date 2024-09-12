import 'package:alternance_flutter/model/Education.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class Educationservice {
  final ApiClient _apiClient = ApiClient();

  Future<List<Education>> fetchEducationById(int studentId) async {
    try {
      final response =
          await _apiClient.dio.get("/api/educations/student/$studentId");

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;

        // Manually map the response data to a list of Education objects
        return data.map((json) => Education.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load education');
      }
    } catch (e) {
      throw Exception('Failed to load education: $e');
    }
  }

  // Update education details
  Future<Education> updateEducation(Education education) async {
    try {
      final response = await _apiClient.dio.put(
        "/api/educations/${education.id}",
        data: education.toJson(), // Convert education object to JSON
      );

      if (response.statusCode == 200) {
        // Return updated education object
        return Education.fromJson(response.data['updatedEducation']);
      } else {
        throw Exception('Failed to update education');
      }
    } catch (e) {
      throw Exception('Failed to update education: $e');
    }
  }
}

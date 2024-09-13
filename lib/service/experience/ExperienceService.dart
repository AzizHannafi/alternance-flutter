import 'package:alternance_flutter/model/Experience.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class Experienceservice {
  final ApiClient _apiClient = ApiClient();

  Future<List<Experience>> fetchExperienceById(int studentId) async {
    try {
      final response =
          await _apiClient.dio.get("/api/experiences/student/$studentId");

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;

        // Manually map the response data to a list of Education objects
        return data.map((json) => Experience.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load experiences');
      }
    } catch (e) {
      throw Exception('Failed to load experiences: $e');
    }
  }

  Future<Experience> updateExperience(Experience experience) async {
    try {
      final response = await _apiClient.dio.put(
        "/api/experiences/${experience.id}",
        data: experience.toJson(), // Convert the experience to JSON
      );

      if (response.statusCode == 200) {
        return Experience.fromJson(response.data["updatedExperience"]);
      } else {
        throw Exception('Failed to update experience');
      }
    } catch (e) {
      throw Exception('Failed to update experience: $e');
    }
  }

  Future<Experience> addExperience(Experience newExperience) async {
    try {
      final response = await _apiClient.dio.post(
        "/api/experiences",
        data: newExperience.toJson(), // Convert the experience to JSON
      );

      if (response.statusCode == 201) {
        // Assuming the response contains the newly created experience
        print('res add exp : ${response.data["newExperience"]}');
        return Experience.fromJson(response.data["newExperience"]);
      } else {
        throw Exception('Failed to add experience');
      }
    } catch (e) {
      throw Exception('Failed to add experience: $e');
    }
  }
}

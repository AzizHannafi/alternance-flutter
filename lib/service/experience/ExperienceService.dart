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
}

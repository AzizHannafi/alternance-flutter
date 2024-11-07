import '../../model/user/University .dart';
import '../ApiClient.dart';

class UniversityService {
  final ApiClient _apiClient = ApiClient();

  Future<University> fetchProfile(int userId) async {
    try {
      final response = await _apiClient.dio.get("/api/universities/user/$userId");

      if (response.statusCode == 200) {
        // Manually map the response data to the Profile model
        return University.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<University> updateProfile(int universityId , University updatedUniversity) async {
    try {
      // Convert the updated student to JSON
      final universityJson = updatedUniversity.toJson();

      // Make the PUT request and pass the student data as the body
      final response = await _apiClient.dio.put(
        "/api/universities/$universityId",
        data: universityJson,
      );

      if (response.statusCode == 200) {
        return University.fromJson(response.data["updatedUniversity"]);
      } else {
        throw Exception('Failed to update Company profile');
      }
    } catch (e) {
      throw Exception('Failed to update Company profile: $e');
    }
  }

  Future<List<University>> fetchUniversity() async {
    try {
      final response = await _apiClient.dio.get("/api/universities");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((universityJson) => University.fromJson(universityJson)).toList();

      } else {
        throw Exception('Failed to load universities');
      }
    } catch (e) {
      throw Exception('Failed to load universities: $e');
    }
  }

  Future<Map<int, String>> fetchUniversityMap() async {
    try {
      final response = await _apiClient.dio.get("/api/universities");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return {
          for (var universityJson in data)
            universityJson['id']: universityJson['universityName']
        };
      } else {
        throw Exception('Failed to load universities');
      }
    } catch (e) {
      throw Exception('Failed to load universities: $e');
    }
  }
}
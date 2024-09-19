import 'package:alternance_flutter/model/Company.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class Companyservice {
  final ApiClient _apiClient = ApiClient();

  Future<Company> fetchProfile(int userId) async {
    try {
      final response = await _apiClient.dio.get("/api/companies/user/$userId");

      if (response.statusCode == 200) {
        // Manually map the response data to the Profile model
        return Company.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<Company> updateProfile(int companyId , Company updatedCompany) async {
    try {
      // Convert the updated student to JSON
      final companyJson = updatedCompany.toJson();

      // Make the PUT request and pass the student data as the body
      final response = await _apiClient.dio.put(
        "/api/companies/$companyId",
        data: companyJson,
      );

      if (response.statusCode == 200) {
        return Company.fromJson(response.data["updatedCompany"]);
      } else {
        throw Exception('Failed to update Company profile');
      }
    } catch (e) {
      throw Exception('Failed to update Company profile: $e');
    }
  }

  Future<List<Company>> fetchCompany() async {
    try {
      final response = await _apiClient.dio.get("/api/companies");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((companyJson) => Company.fromJson(companyJson)).toList();
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {

      throw Exception('Failed to load companies: $e');
    }
  }
}

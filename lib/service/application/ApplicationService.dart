import 'dart:io';

import 'package:alternance_flutter/model/applicationOfferStudent/Application.dart';
import 'package:alternance_flutter/model/ApplicationDto.dart';
import 'package:alternance_flutter/service/ApiClient.dart';
import 'package:dio/dio.dart';

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
      throw Exception('Failed to load Applications: $e');
    }
  }

  Future<List<Application>> fetchApplicationByCompany(int companyId) async {
    try {
      final response =
      await _apiClient.dio.get('/api/applications/company/$companyId');

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;
print('*****************************${response.data}');
        // Manually map the response data to a list of Education objects
        return data.map((json) => Application.fromJson(json)).toList();
      } else {
        print('*****************************${response.data}');

        throw Exception('Failed to load Applications');
      }
    } catch (e) {
      print('*****************************errrrrr${e}');

      throw Exception('Failed to load Applications: $e');
    }
  }

  Future<List<Application>> fetchApplicationByUniversity(int universityId) async {
    try {
      final response =
      await _apiClient.dio.get('/api/applications/university/$universityId?statuses=accepted,validated,invalidated');

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;
        print('*****************************${response.data}');
        // Manually map the response data to a list of Education objects
        return data.map((json) => Application.fromJson(json)).toList();
      } else {
        print('*****************************${response.data}');

        throw Exception('Failed to load Applications');
      }
    } catch (e) {
      print('*****************************errrrrr${e}');

      throw Exception('Failed to load Applications: $e');
    }
  }

  Future<bool> checkApplicationExist(int studentId, int offerId) async {
    try {
      // Fetch applications for the specified student
      List<ApplicationDto> applications = await fetchApplicationByStudent(studentId);

      // Check if any application matches the given offerId
      for (ApplicationDto application in applications) {
        if (application.offerId == offerId && application.studentId==studentId) {
          return true; // Application with the matching offerId found
        }
      }
      return false; // No matching application found
    } catch (e) {
      print("Error in checkApplicationExist: $e");
      return false; // Return false if there was an error fetching or checking applications
    }
  }

  Future<void> applyForJob({
    required int studentId,
    required int offerId,
    required String description,
    required File file, // List of files to upload
  }) async {
    try {
      // TODO : make api call to verify that there's no application with the same usr ID AND offerID
      //CheckApplicationExist(userId,OfferId)
      // Create FormData to send the data in multi-part form
      FormData formData = FormData.fromMap({
        'studentId': studentId.toString(),
        'offerId': offerId.toString(),
        'description': description,
        'status': "pending",
        'applicationDate': DateTime.now().toIso8601String(),
        // Map files to multipart
        'resume': MultipartFile.fromFileSync(file.path),
      });

      // Perform POST request
      final response =
          await _apiClient.dio.post("/api/applications/files", data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Application submitted successfully!');
      } else {
        throw Exception('Failed to submit application');
      }
    } catch (e) {
      print('Error submitting application: $e');
      throw Exception('Error submitting application: $e');
    }
  }
  Future<void> updateApplicationStatus(int applicationId, String status) async {
    try {
      Map<String, dynamic> body = {
        "status": status,
      };

      // Perform the PUT request to update the application status
      final response = await _apiClient.dio.put(
        "/api/applications/$applicationId",
        data: body,
      );

      if (response.statusCode == 200) {
        print('Application status updated successfully!');
      } else {
        throw Exception('Failed to update application status');
      }
    } catch (e) {
      print('Error updating application status: $e');
      throw Exception('Error updating application status: $e');
    }
  }

}

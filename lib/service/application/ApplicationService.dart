import 'dart:io';

import 'package:alternance_flutter/model/Application.dart';
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

  Future<void> applyForJob({
    required int studentId,
    required int offerId,
    required String description,
    required File file, // List of files to upload
  }) async {
    try {
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
}

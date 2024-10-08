import 'package:alternance_flutter/model/Certificate.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class Certificateservice {
  final ApiClient _apiClient = ApiClient();

  Future<List<Certificate>> fetchCertificateById(int studentId) async {
    try {
      final response =
          await _apiClient.dio.get("/api/certificates/student/$studentId");

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;

        // Manually map the response data to a list of Education objects
        return data.map((json) => Certificate.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      throw Exception('Failed to load certificates: $e');
    }
  }

  Future<Certificate> updateCertificate(Certificate certificate) async {
    try {
      final response = await _apiClient.dio.put(
        "/api/certificates/${certificate.id}",
        data: certificate.toJson(), // Convert the certificate to JSON
      );

      if (response.statusCode == 200) {
        return Certificate.fromJson(response.data["updatedCertificate"]);
      } else {
        throw Exception('Failed to update certificate');
      }
    } catch (e) {
      throw Exception('Failed to update certificate: $e');
    }
  }

  Future<Certificate> addCertificate(Certificate certificate) async {
    try {
      final response = await _apiClient.dio.post(
        "/api/certificates",
        data: certificate.toJson(), // Convert the certificates to JSON
      );

      if (response.statusCode == 201) {
        // Assuming the response contains the newly created experience
        print('res add exp : ${response.data["newCertificate"]}');
        return Certificate.fromJson(response.data["newCertificate"]);
      } else {
        throw Exception('Failed to add certificate');
      }
    } catch (e) {
      throw Exception('Failed to add certificate: $e');
    }
  }

  Future<String> deleteCertificate(int certificateId) async {
    try {
      final response = await _apiClient.dio.delete(
        "/api/certificates/$certificateId",
      );

      if (response.statusCode == 200) {
        print(
            'res add exp : ${response.data["deletedCertificate"]["message"]}');
        return response.data["deletedCertificate"]["message"];
      } else {
        throw Exception('Failed to  delete Certificate');
      }
    } catch (e) {
      throw Exception('Failed to  delete Certificate: $e');
    }
  }
}

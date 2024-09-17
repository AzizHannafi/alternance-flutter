import 'package:flutter/material.dart';

class ColorsUtils {
  static const Color primaryBleu = Color(0xff0d152c);
  static const Color primaryGreen = Color(0xff43a687);
  static const Color transparentGreen = Color.fromARGB(48, 67, 166, 135);
  static const Color primaryWhite = Color(0xfff5f5f5);
  static const Color primaryPurpule = Colors.deepPurple;
  static const Color lightGray = Color.fromARGB(255, 255, 255, 255);
  static const Color white = Colors.white;
  static const Color transparentPurple = Color.fromARGB(52, 104, 58, 183);
  static const Color transparentBlue = Color.fromARGB(47, 4, 57, 218);
  static const Color transparentGrey = Color.fromARGB(48, 13, 21, 44);

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.lightBlue;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.grey;
      case 'shortlisted':
        return const Color.fromARGB(255, 252, 192, 102);
      case 'validated':
        return ColorsUtils.primaryGreen;
      case 'invalidated':
        return Colors.red;
      default:
        return Colors.grey; // Default color for unknown status
    }
  }
}

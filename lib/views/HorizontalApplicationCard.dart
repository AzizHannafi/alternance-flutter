import 'package:alternance_flutter/views/application/StudentCardContent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Horizontalapplicationcard extends StatelessWidget {
  final dynamic application;
  Horizontalapplicationcard({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 7,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      //margin: const EdgeInsets.symmetric(vertical: 8.0),

      child: Studentcardcontent(application: application),
    );
  }

}

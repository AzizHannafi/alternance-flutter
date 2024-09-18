import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/ApplicationDto.dart';
import '../../utils/ColorsUtils.dart';

class Studentcardcontent extends StatelessWidget {
  final ApplicationDto application;

   Studentcardcontent({super.key,required this.application});


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,

      padding: EdgeInsets.only(right: 20,left: 20,bottom: 10,top: 10),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: ColorsUtils.getStatusColor(application.status),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              application.status.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Offer :${application.offer.title}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),

          const SizedBox(height: 8),
          Text(
            'Company Name: ${application.offer.company.companyName}',
            style: const TextStyle(
              fontSize: 16,
              color: ColorsUtils.primaryBleu,
            ),
          ),
          const SizedBox(height: 8),
          Text('Application Date :${DateFormat('yyyy-MM-dd').format(application.applicationDate)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

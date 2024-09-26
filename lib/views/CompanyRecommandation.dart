import 'package:alternance_flutter/service/company/CompanyService.dart';
import 'package:alternance_flutter/views/ViewProfile.dart';
import 'package:alternance_flutter/views/offer/CompanyCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Company.dart';
import '../utils/ColorsUtils.dart';
import 'NoData.dart';

class CompanyRecommandation extends StatefulWidget {

  const CompanyRecommandation({super.key});

  @override
  State<CompanyRecommandation> createState() => _CompanyRecommandationState();
}

class _CompanyRecommandationState extends State<CompanyRecommandation> {
  late Future<List<Company>> _companyFuture;

  @override
  void initState() {
    super.initState();
    final companyService = Companyservice();
    _companyFuture = companyService.fetchCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adds padding around the container
      child: Container(
        // height: 400, // Ensure a defined height
        width: double.infinity, // Occupies the full width
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.business, color: ColorsUtils.primaryGreen),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Companies Recommendation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.primaryBleu,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Company>>(
              future: _companyFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Container(
                    height: 300,
                    child: Nodata(filed: "No Company available"),
                  ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Container(
                    height: 300,
                    child: Nodata(filed: "No Company available"),
                  ));
                } else {
                  // Extract the list of offers from the Offers object
                  final companies = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: companies
                          .map((company) => CompanyCard(company: company),)
                          .toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

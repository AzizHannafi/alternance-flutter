// Updated import for OfferDetails
import 'package:alternance_flutter/model/Company.dart';
import 'package:alternance_flutter/service/Offer/OfferService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/model/Offers.dart';
import 'package:alternance_flutter/views/search/UserSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/Offer.dart';
import '../../service/company/CompanyService.dart';
import '../../utils/SharedPreferencesUtils.dart';
import 'OfferDetails.dart';



class OfferFeedPage extends StatefulWidget {
  const OfferFeedPage({super.key});

  @override
  _OfferFeedPageState createState() => _OfferFeedPageState();
}

class _OfferFeedPageState extends State<OfferFeedPage> {
  Future<Offers>? _offersFuture;
  List<Offer> _allOffers = []; // All offers retrieved from the API
  List<Offer> _filteredOffers = []; // Offers after filtering
  String _role = "";
  int profileId = 0;

  // Filter criteria variables
  String searchQuery = '';
  String employmentType = '';
  String university = '';
  String status = '';

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    final offerService = OfferService();
    await SharedPreferencesUtils.init();

    setState(() {
      _role = SharedPreferencesUtils.getValue<String>("role") ?? "";
    });

    if (_role.contains("company")) {
      final Companyservice service = Companyservice();
      Future<Company> _CompanyFuture = service.fetchProfile(SharedPreferencesUtils.getValue<int>("id")!);

      _CompanyFuture.then((profile) {
        setState(() {
          profileId = profile.id;
          _offersFuture = offerService.fetchCompanyOffers(profile.id);
          _offersFuture?.then((offersData) {
            _allOffers = offersData.offers;
            _filteredOffers = List.from(_allOffers); // Initialize filtered offers
          });
        });
      }).catchError((error) {
        print('Error: $error');
      });
    } else {
      setState(() {
        _offersFuture = offerService.fetchOffers();
        _offersFuture?.then((offersData) {
          _allOffers = offersData.offers;
          _filteredOffers = List.from(_allOffers); // Initialize filtered offers
        });
      });
    }
  }

  // Method to apply filters
  void filterOffers() {
    setState(() {
      _filteredOffers = _allOffers.where((offer) {
        final matchesSearchQuery = offer.title.contains(searchQuery) || offer.description.contains(searchQuery);
        final matchesEmploymentType = employmentType.isEmpty || offer.employmentType == employmentType;
        final matchesStatus = status.isEmpty || offer.status == status;
        return matchesSearchQuery && matchesEmploymentType && matchesStatus;
      }).toList();
    });
  }

  // Update the filter and apply
  void onSearchChanged(String query) {
    searchQuery = query;
    filterOffers();
  }
  void onApplyFilters() {
    filterOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _offersFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<Offers>(
        future: _offersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: UserSearchBar(
                      onSearchChanged: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                        filterOffers();
                      },
                      onEmploymentTypeChanged: (type) {
                        setState(() {
                          employmentType = type ?? '';
                        });
                        filterOffers();
                      },
                      onApplyFilters: onApplyFilters,
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredOffers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final offer = _filteredOffers[index];
                        return Material(
                          elevation: 1.0,
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            height: 136,
                            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorsUtils.primaryBleu),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        offer.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        offer.description,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => OfferDetails(offer: offer),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: ColorsUtils.transparentGreen,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: SvgPicture.asset(
                                        'assets/company.svg',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

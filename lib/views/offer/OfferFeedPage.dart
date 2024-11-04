// Updated import for OfferDetails
import 'package:alternance_flutter/model/Company.dart';
import 'package:alternance_flutter/service/Offer/OfferService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/NoData.dart';
import 'package:alternance_flutter/views/offer/EditOffer.dart';
import 'package:alternance_flutter/views/search/UserSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/offers/Offer.dart';
import '../../model/offers/Offers.dart';
import '../../service/company/CompanyService.dart';
import '../../utils/SharedPreferencesUtils.dart';
import 'NewOffer.dart';
import 'OfferDetails.dart';

class OfferFeedPage extends StatefulWidget {
  const OfferFeedPage({super.key});

  @override
  _OfferFeedPageState createState() => _OfferFeedPageState();
}

class _OfferFeedPageState extends State<OfferFeedPage> {
  final offerService = OfferService();
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

    await SharedPreferencesUtils.init();

    setState(() {
      _role = SharedPreferencesUtils.getValue<String>("role") ?? "";
    });

    if (_role.contains("company")) {
      final Companyservice service = Companyservice();
      Future<Company> _CompanyFuture =
          service.fetchProfile(SharedPreferencesUtils.getValue<int>("id")!);

      _CompanyFuture.then((profile) {
        setState(() {
          profileId = profile.id;
          _offersFuture = offerService.fetchCompanyOffers(profile.id);
          _offersFuture?.then((offersData) {
            _allOffers = offersData.offers;
            _filteredOffers =
                List.from(_allOffers); // Initialize filtered offers
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
        final matchesSearchQuery = offer.title
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            offer.description.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesEmploymentType =
            employmentType.isEmpty || offer.employmentType == employmentType;
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
  void _showDeleteOfferConfirmationDialog(
      BuildContext context, int offerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Delete Offer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete this offer entry?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: ColorsUtils.primaryGreen),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                // Call the delete offer function when confirmed
                await _deleteOffer(context, offerId);
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteOffer(BuildContext context, int offerId) async {
    try {
      // Call the API to delete the offer
      final response = await offerService.deleteOffer(offerId);

      // Check if the deletion was successful
      if (response['success'] == true) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message'],
              style: const TextStyle(color: ColorsUtils.primaryGreen),
            ),
          ),
        );
      } else {
        // Show error message from response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to delete offer: ${response['message']}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        );
      }
    } catch (e) {
      // Show error message if an exception occurs
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to delete offer: $e',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }
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
                  return const Center(child: Nodata(filed: 'No Offer available in this status'));
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorsUtils.primaryBleu),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:     MainAxisAlignment.end,
                                        children: [

                                        Visibility(visible: _role.contains("company"),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: ColorsUtils.primaryGreen,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => EditOffer(offer: offer,),
                                                ));
                                              },
                                            )),
                                        Visibility(visible: _role.contains("company"),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),

                                              onPressed: () {
                                                _showDeleteOfferConfirmationDialog(
                                                    context, offer.id);
                                              },
                                            )),
                                      ],),

                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              offer.title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              offer.description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OfferDetails(offer: offer),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: ColorsUtils.transparentGreen,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
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
      floatingActionButton: _role == "company"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewOffer(
                      companyId: profileId,
                       ),
                  ),
                );

              },
              backgroundColor: ColorsUtils.primaryGreen,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

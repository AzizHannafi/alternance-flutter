import 'package:alternance_flutter/model/offers/Offer.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/utils/DateUtilsC.dart';
import 'package:alternance_flutter/views/JobApply.dart';
import 'package:flutter/material.dart';

import '../../utils/SharedPreferencesUtils.dart';

class OfferDetails extends StatefulWidget {
  final Offer? offer;

  const OfferDetails({super.key, required this.offer});

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  String selectedContent = 'Description';
  String _role = "";

  void updateContent(String content) {
    setState(() {
      selectedContent = content;
    });
  }

  Future<void> _initializePreferences() async {
    // Await for SharedPreferences initialization
    await SharedPreferencesUtils.init();

    // Load the user role after the preferences are initialized
    setState(() {
      _role = SharedPreferencesUtils.getValue<String>("role") ?? "";
    });
  }

  Widget displayContent() {
    switch (selectedContent) {
      case 'Description':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Offer Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Title: ${widget.offer!.title}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Description: ${widget.offer!.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Salary: \$${widget.offer!.salary ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Duration: ${widget.offer!.duration ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Employment Type: ${widget.offer!.employmentType ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Location: ${widget.offer!.location ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Status: ${widget.offer!.status ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Created At: ${DateUtilsC.formatDateString(widget.offer!.createdAt)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
          ],
        );
      // Use the offer's description
      case 'University':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "University description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'University: ${widget.offer!.university?.universityName ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Location: ${widget.offer!.university?.location ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'About: ${widget.offer!.university?.about ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'Contact Info: ${widget.offer!.university?.contactInfo ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8), // Add some spacing
            Text(
              'socialMedia: ${widget.offer!.university?.socialMedia ?? "N/A"}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      default:
        return Text(
          widget.offer!.description,
          style: const TextStyle(fontSize: 16),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // DateTime createdAt = DateTime.parse(widget.offer!.createdAt);
    // String createdAtOffer = DateFormat('yyyy/MM/dd').format(createdAt);
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonStyle = BoxDecoration(
      color: ColorsUtils.transparentGreen,
      borderRadius: BorderRadius.circular(8),
    );

    const textStyle = TextStyle(
      color: ColorsUtils.primaryBleu,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer!.title), // Use the offer's title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: screenWidth * 0.9,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsUtils.primaryBleu),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: ColorsUtils.transparentGreen,
                      borderRadius:
                          BorderRadius.circular(50), // Half of the width/height
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://e7.pngegg.com/pngimages/592/963/png-clipart-commercial-building-computer-icons-management-building-building-company.png",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Job Title
                  Text(
                    widget.offer!.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Company Name
                  Text(
                    '${widget.offer!.company.companyName}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Actions Row (Status, Created At)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: buttonStyle,
                          child: Center(
                            child: Text(
                              widget.offer!.status,
                              style: textStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // Add spacing between buttons
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: buttonStyle,
                          child: Center(
                            child: Text(
                              // widget.offer!.createdAt,
                              DateUtilsC.formatDateString(
                                  widget.offer!.createdAt),
                              style: textStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      padding: const EdgeInsets.all(8),
                      // Padding around the icon
                      decoration: const BoxDecoration(
                        color: ColorsUtils.transparentGreen, // Background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.monetization_on_outlined,
                          size: 30, // Icon size
                          color: ColorsUtils.primaryGreen, // Icon color
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Replace with your icon
                    const Text('Salary'),
                    const SizedBox(height: 5),
                    Text(
                        widget.offer!.salary != null
                            ? widget.offer!.salary.toString()
                            : "N/A",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      padding: const EdgeInsets.all(8),
                      // Padding around the icon
                      decoration: const BoxDecoration(
                        color: ColorsUtils.transparentBlue, // Background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.business_center_outlined,
                          size: 30, // Icon size
                          color: ColorsUtils.primaryBleu, // Icon color
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Replace with your icon
                    const Text('Job Type'),
                    const SizedBox(height: 5),
                    Text(
                        widget.offer!.locationType != null
                            ? widget.offer!.locationType.toString()
                            : "N/A",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      padding: const EdgeInsets.all(8),
                      // Padding around the icon
                      decoration: const BoxDecoration(
                        color:
                            ColorsUtils.transparentPurple, // Background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.timer_outlined,
                          size: 30, // Icon size
                          color: ColorsUtils.primaryPurpule, // Icon color
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Replace with your icon
                    const Text("Duration"),
                    const SizedBox(height: 5),
                    Text(
                      widget.offer!.duration != null
                          ? widget.offer!.duration
                          : "N/A",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => updateContent('Description'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedContent == 'Description'
                            ? ColorsUtils.transparentBlue
                            : ColorsUtils.transparentGrey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          'Description',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => updateContent('University'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedContent == 'University'
                            ? ColorsUtils.transparentBlue
                            : ColorsUtils.transparentGrey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          'University',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SingleChildScrollView(
                    child: displayContent(),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _role.contains("student"),
              child: Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: screenWidth,
                    height: 50,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Jobapply(
                                offerId: widget.offer!.id,
                              ),
                            ));
                      },
                      backgroundColor: ColorsUtils.primaryGreen,
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

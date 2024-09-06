import 'package:alternance_flutter/model/Offer.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/model/Offers.dart'; // Ensure the import for the offer model

class OfferDetails extends StatefulWidget {
  final Offer? offer;
  const OfferDetails({Key? key, required this.offer}) : super(key: key);

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  String selectedContent = 'Description';

  void updateContent(String content) {
    setState(() {
      selectedContent = content;
    });
  }

  Widget displayContent() {
    switch (selectedContent) {
      case 'Description':
        return Text(widget.offer!.description); // Use the offer's description
      case 'University':
        return const Text(
          'Details about the University...',
          style: TextStyle(fontSize: 17),
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
        title: Text(widget.offer!.title!), // Use the offer's title
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
                    width: 100,
                    height: 100,
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
                    'Senior UI/UX Designer',
                    style: const TextStyle(
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
                    'Shopee Sg',
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
                            child: const Text(
                              'Status',
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
                              'Created At',
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
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: ColorsUtils.transparentGreen,
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://e7.pngegg.com/pngimages/592/963/png-clipart-commercial-building-computer-icons-management-building-building-company.png",
                  ), // Offer's image
                ),
              ),
            ),
            const SizedBox(height: 8),

            Text(
              widget.offer!.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.offer!.company
                  .companyName, // Use the company name from the offer
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            // Additional details (salary, job type, etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(8), // Padding around the icon
                      decoration: const BoxDecoration(
                        color: ColorsUtils.transparentGreen, // Background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.monetization_on_outlined,
                          size: 40, // Icon size
                          color: ColorsUtils.primaryGreen, // Icon color
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Replace with your icon
                    const Text('Salary'),
                    const SizedBox(height: 5),
                    Text(widget.offer!.salary.toString()),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(8), // Padding around the icon
                      decoration: const BoxDecoration(
                        color: ColorsUtils.transparentBlue, // Background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.business_center_outlined,
                          size: 40, // Icon size
                          color: ColorsUtils.primaryBleu, // Icon color
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Replace with your icon
                    Text('Job Type'),
                    const SizedBox(height: 5),
                    Text(widget.offer!.locationType.toString()),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.all(8), // Padding around the icon
                      decoration: const BoxDecoration(
                        color:
                            ColorsUtils.transparentPurple, // Background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.timer_outlined,
                          size: 40, // Icon size
                          color: ColorsUtils.primaryPurpule, // Icon color
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Replace with your icon
                    const Text("Duration"),
                    const SizedBox(height: 5),
                    Text(widget.offer!.duration),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Display the selected content
            Expanded(
              child: SingleChildScrollView(
                child: displayContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

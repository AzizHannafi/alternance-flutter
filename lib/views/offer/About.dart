import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'About Me',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: ColorsUtils.primaryBleu,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Add your edit functionality here
                },
                icon: const Icon(
                  Icons.edit,
                  // size: 50,
                ),
                color: ColorsUtils.primaryGreen,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Libero, cursus molestie nullam ac pharetra est nec enim. Vel eleifend semper nunc faucibus donec pretium.',
            style: TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

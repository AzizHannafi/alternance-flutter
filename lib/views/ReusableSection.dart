import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class ReusableSection extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onEdit;

  const ReusableSection({
    super.key,
    required this.title,
    required this.content,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 300, // Set a maximum height for the education section
      ),
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
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: ColorsUtils.primaryBleu,
                ),
              ),
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  color: ColorsUtils.primaryGreen,
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          Expanded(child: content), // Use the widget passed as content
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StatusFilterDropdown extends StatelessWidget {
  final String? selectedStatus;
  final Function(String?) onStatusChanged;

  StatusFilterDropdown({
    Key? key,
    required this.selectedStatus,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Set background color to white
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        hint: const Text("Filter by Status"),
        value: selectedStatus,
        isExpanded: true, // Make dropdown full width
        underline: SizedBox(), // Remove underline
        dropdownColor: Colors.white, // Set dropdown menu background color
        items: ['Accepted', 'Pending', 'Rejected', 'Shortlisted', 'Validated', 'Invalidated']
            .map((status) => DropdownMenuItem(
          value: status.toLowerCase(),
          child: Text(status),
        ))
            .toList(),
        onChanged: onStatusChanged,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class UserSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onEmploymentTypeChanged;
  final VoidCallback onApplyFilters;

  const UserSearchBar({
    Key? key,
    required this.onSearchChanged,
    required this.onEmploymentTypeChanged,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<UserSearchBar> createState() => _UserSearchBarState();
}

class _UserSearchBarState extends State<UserSearchBar> {
  String _searchQuery = "";
  String? _selectedEmploymentType;

  final List<String> _employmentTypes = ['Full time', 'Half time', 'Freelance'];

  void _resetFilters() {
    setState(() {
      _searchQuery = "";
      _selectedEmploymentType = null;
    });
    widget.onSearchChanged(_searchQuery);
    widget.onEmploymentTypeChanged(_selectedEmploymentType);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search Offer by title...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
            widget.onSearchChanged(value);
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Employment Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          value: _selectedEmploymentType,
          items: _employmentTypes
              .map((type) => DropdownMenuItem(
            value: type.toLowerCase(),
            child: Text(type),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedEmploymentType = value;
            });
            widget.onEmploymentTypeChanged(value);
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onApplyFilters,
                child: const Text('Apply Filters'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: _resetFilters,
                child: const Text('Reset'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

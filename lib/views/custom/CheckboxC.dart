import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Checkboxc extends StatelessWidget {
  final String imagePth;
  final Text text;
  final bool isSelected;
  final VoidCallback onSelected;

  const Checkboxc({
    super.key,
    required this.imagePth,
    required this.text,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SvgPicture.asset(
              imagePth,
              width: 40,
              height: 40,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            text,
            Checkbox(
              value: isSelected,
              onChanged: (value) => onSelected(),
            ),
          ],
        ),
      ),
    );
  }
}

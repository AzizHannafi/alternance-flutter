import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Nodata extends StatelessWidget {
  final String filed;
  const Nodata({super.key, required this.filed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Oh no $filed yet! add some',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            "assets/cat.svg",
            width: 40,
            height: 40,
          )
        ],
      ),
    );
  }
}

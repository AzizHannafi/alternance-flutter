import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/News.dart';
import 'package:alternance_flutter/views/Offer.dart';
import 'package:alternance_flutter/views/Saved.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> pages = const [Offer(), Saved(), News()];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: ColorsUtils.lightGray,
        child: Text("Hello from Home"),
      ),
    );
  }
}

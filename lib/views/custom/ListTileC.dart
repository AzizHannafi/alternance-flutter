import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';

class ListTileC extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const ListTileC({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _ListTileCState createState() => _ListTileCState();
}

class _ListTileCState extends State<ListTileC> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          color: widget.isSelected || _isHovered
              ? ColorsUtils.transparentGreen
              : ColorsUtils.white, // Default transparent green color
          child: ListTile(
            title: Text(widget.title),
            leading: Icon(widget.icon),
          ),
        ),
      ),
    );
  }
}

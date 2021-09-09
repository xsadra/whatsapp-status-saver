import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
    this.color = Colors.black87,
    this.tooltip,
    this.boxSize = 56.0,
    this.iconSize = 40.0,
  }) : super(key: key);

  final double boxSize;
  final Null Function() onPressed;
  final IconData iconData;
  final Color color;
  final String? tooltip;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxSize,
      width: boxSize,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(boxSize),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(iconData),
          color: color,
          tooltip: tooltip,
          iconSize: iconSize,
        ),
      ),
    );
  }
}

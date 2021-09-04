import 'package:flutter/material.dart';

class CircularItem extends StatelessWidget {
  const CircularItem({
    Key? key,
    required this.radius,
    required this.child,
  }) : super(key: key);

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(-5, 5)),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}

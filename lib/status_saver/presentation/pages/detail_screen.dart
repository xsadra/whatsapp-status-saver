import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(imagePath, fit: BoxFit.fitWidth),
      ),
    );
  }
}

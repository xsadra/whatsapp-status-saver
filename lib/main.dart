import 'package:flutter/material.dart';

import 'status_saver/presentation/pages/pages.dart' show HomeScreen;

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Status Saver',
      home: HomeScreen(),
    );
  }
}

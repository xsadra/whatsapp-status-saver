import 'dart:developer';

import 'package:flutter/material.dart' hide Router;

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('build', name: 'SplashPage');

    return Scaffold(
      body: Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

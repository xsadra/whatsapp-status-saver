import 'dart:io';

import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Uri uri;
  final double height;
  final VoidCallback onSave;

  const DetailsScreen({
    Key? key,
    required this.uri,
    required this.onSave,
    required this.height,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String tag = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
            children: [
              Spacer(
                flex: 5,
              ),
              Hero(
                tag: widget.uri.path + tag,
                child: Image.file(
                  File.fromUri(widget.uri),
                  height: widget.height,
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
          child: ElevatedButton(
            onPressed: () {
              widget.onSave();
              setState(() {
                tag = 'tag';
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ),
      ),
    );
  }
}

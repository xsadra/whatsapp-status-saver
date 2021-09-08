import 'package:flutter/material.dart';

import '../widgets/widgets.dart' show ShowMediaDetail;

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          children: [
            Spacer(
              flex: 5,
            ),
            Hero(
              tag: widget.uri.path + tag,
              child: ShowMediaDetail(
                uri: widget.uri,
                height: widget.height,
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return SafeArea(
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
    );
  }
}

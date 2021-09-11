import 'package:flutter/material.dart';

import '../widgets/widgets.dart' show CustomIconButton, ShowMediaDetail;

class DetailsScreen extends StatefulWidget {
  final Uri uri;
  final double height;
  final bool showButtons;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final String? tag;

  const DetailsScreen({
    Key? key,
    required this.uri,
    required this.height,
    this.showButtons = true,
    required this.onSave,
    this.onDelete,
    this.tag,
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
      ),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: widget.tag ?? widget.uri.path + tag,
                child: ShowMediaDetail(
                  uri: widget.uri,
                  height: widget.height,
                ),
              ),
            ),
            if (widget.showButtons)
              Positioned(
                left: 0,
                right: 0,
                bottom: widget.height * 0.03,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CustomIconButton(
                      //   onPressed: () => _onRepost(context),
                      //   iconData: Icons.repeat,
                      //   tooltip: 'Repost Image',
                      //   color: Colors.orange,
                      // ),
                      CustomIconButton(
                        onPressed: () => _onSave(context),
                        iconData: Icons.save_alt,
                        tooltip: 'Save Image',
                      ),
                      // CustomIconButton(
                      //   onPressed: () => _onDelete(context),
                      //   iconData: Icons.delete_forever,
                      //   tooltip: 'Delete Image',
                      //   color: Colors.red,
                      // ),
                      // CustomIconButton(
                      //   onPressed: () => _onShare(context),
                      //   iconData: Icons.share,
                      //   tooltip: 'Share Image',
                      //   color: Colors.green,
                      // ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Null _onSave(BuildContext context) {
    widget.onSave();
    setState(() {
      tag = 'tag';
    });
    Navigator.pop(context);
  }
//
// Null _onDelete(BuildContext context) {
//   widget.onDelete!();
//   setState(() {
//     tag = 'tag';
//   });
//   Navigator.pop(context);
// }
//
// Null _onRepost(BuildContext context) {}
//
// Null _onShare(BuildContext context) {}
}

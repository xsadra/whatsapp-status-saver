import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final Text? text;
  final bool? isOnlyText;
  final double? radius;
  final double? borderWidth;
  final String? imagePath;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? placeHolder;
  final Widget? errorWidget;

  const CircularAvatar({
    Key? key,
    this.isOnlyText = false,
    this.radius = 50,
    this.borderWidth = 0,
    this.imagePath = '',
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.placeHolder,
    this.errorWidget,
    this.text,
  }) : super(key: key);

  Widget getTextWidget() {
    print(radius);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: Container(
          padding: EdgeInsets.all(borderWidth!),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius!),
              color: backgroundColor),
          child: Center(child: text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius! * 2 + 2,
      width: radius! * 2 + 2,
      padding: EdgeInsets.all(borderWidth!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!), color: borderColor),
      child: Container(
        height: radius! * 2,
        width: radius! * 2,
        padding: EdgeInsets.all(borderWidth!),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius!), color: Colors.white),
        child: isOnlyText!
            ? getTextWidget()
            : imagePath!.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(radius!),
                    child: Container(
                      color: backgroundColor,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(radius!),
                    child: Image.asset(imagePath!, fit: BoxFit.cover),
                  ),
      ),
    );
  }
}

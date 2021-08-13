import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart'
    show kDefaultPadding, kHeaderHeight;

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/header.jpg',
            // height: 185,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kDefaultPadding),
                bottomRight: Radius.circular(kDefaultPadding),
              ),
            ),
            height: kHeaderHeight,
            //color: Colors.black12,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      "Good Morning!",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Spacer(),
                    Text(
                      "Status Saver",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.black54),
                    ),
                    Spacer(),
                  ],
                ),
                Image.asset(
                  "assets/images/whatsapp.webp",
                  width: 36,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

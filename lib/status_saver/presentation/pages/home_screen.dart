import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/size_config.dart';
import '../../../core/constants/constants.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<String> paths = [
      'assets/images/profile.png',
      'assets/images/james.png',
      'assets/images/John.png',
      'assets/images/marry.png',
      'assets/images/profile.png',
      'assets/images/rosy.png',
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              backgroundImage: 'assets/images/home_bg.png',
              title: 'Status Saver',
              subTitle: 'Statuses',
            ),
            VerticalSpacing(),
            SectionTitle(title: 'Images', onTap: () {}),
            VerticalSpacing(),
            StatusImageCollection(paths: paths),
            VerticalSpacing(),
            SectionTitle(title: 'Videos', onTap: () {}),
            VerticalSpacing(),
            StatusImageCollection(paths: paths.sublist(3)),
            VerticalSpacing(),
            SectionTitle(title: 'Saved', onTap: () {}),
            VerticalSpacing(),
            StatusImageCollection(paths: paths.sublist(5)),
            VerticalSpacing(),
          ],
        ),
      ),
    );
  }

  AppBar get buildAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.menu,
          color: kIconColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/whatsapp.png'),
        ),
      ],
    );
  }
}

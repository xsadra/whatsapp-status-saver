import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/size_config.dart';
import '../../../core/constants/constants.dart';
import '../widgets/widgets.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<String> paths = [
      'assets/images/profile.webp',
      'assets/images/james.webp',
      'assets/images/John.webp',
      'assets/images/marry.webp',
      'assets/images/profile.webp',
      'assets/images/rosy.webp',
    ];
    List<String> paths2 = [
      'assets/images/pic1.jpg',
      'assets/images/pic2.jpg',
      'assets/images/pic3.jpg',
      'assets/images/pic4.jpg',
      'assets/images/pic5.jpg',
      'assets/images/pic6.jpg',
      'assets/images/pic7.jpg',
      'assets/images/pic8.jpg',
      'assets/images/pic9.jpg',
      'assets/images/pic10.jpg',
      'assets/images/pic11.jpg',
      'assets/images/pic12.jpg',
      'assets/images/pic13.jpg',
      'assets/images/pic14.jpg',
      'assets/images/pic15.jpg',
      'assets/images/pic16.jpg',
      'assets/images/pic17.jpg',
      'assets/images/pic18.jpg',
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar,
      body: buildBody(paths2),
    );
  }

  SingleChildScrollView buildBody(List<String> paths) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
            backgroundImage: 'assets/images/home_bg.webp',
            title: 'Status Saver',
            subTitle: 'Statuses',
          ),
          VerticalSpacing(),
          SectionTitle(title: 'Images', onTap: () {}),
          VerticalSpacing(),
          StatusImageCollection(paths: paths.sublist(1)),
          VerticalSpacing(),
          SectionTitle(title: 'Videos', onTap: () {}),
          VerticalSpacing(),
          StatusImageCollection(paths: paths.sublist(8)),
          VerticalSpacing(),
          SectionTitle(title: 'Saved', onTap: () {}),
          VerticalSpacing(),
          StatusImageCollection(paths: paths.sublist(14)),
          VerticalSpacing(),
        ],
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
          icon: Image.asset('assets/images/whatsapp1.webp'),
        ),
      ],
    );
  }
}

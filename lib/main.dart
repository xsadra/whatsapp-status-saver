import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/configs/size_config.dart';
import 'core/constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Status Saver',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<String> paths = [
      'assets/images/james.png',
      'assets/images/John.png',
      'assets/images/marry.png',
      'assets/images/profile.png',
      'assets/images/rosy.png',
      'assets/images/profile.png',
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            buildHomeHeader(),
            VerticalSpacing(),
            SectionTitle(title: 'Images', onTap: () {}),
            VerticalSpacing(),
            StatusImageCollection(paths: paths),
            VerticalSpacing(),
            SectionTitle(title: 'Videos', onTap: () {}),
            VerticalSpacing(),
            StatusImageCollection(paths: paths),
            VerticalSpacing(),
            SectionTitle(title: 'Saved', onTap: () {}),
            VerticalSpacing(),
            StatusImageCollection(paths: paths),
            VerticalSpacing(),
            SizedBox(height: 300),
          ],
        ),
      ),
    );
  }

  Stack buildHomeHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/home_bg.png',
          height: getProportionateScreenWidth(315),
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(77)),
            Text(
              'Status Saver',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(65),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 0.5,
              ),
            ),
            Text(
              'Statuses',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }

  AppBar buildAppBar() {
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

class StatusImageCollection extends StatelessWidget {
  const StatusImageCollection({
    Key? key,
    required this.paths,
  }) : super(key: key);

  final List<String> paths;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            paths.length > 5 ? 5 : paths.length,
            (index) => Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
              child: StatusImage(imagePath: paths.elementAt(index)),
            ),
          ),
          if (paths.length > 5)
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
              child: StatusImage(imagePath: 'assets/images/more.png'),
            ),
        ],
      ),
    );
  }
}

class StatusImage extends StatelessWidget {
  const StatusImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CircularAvatar(
      imagePath: imagePath,
      radius: 60,
      borderColor: Colors.green,
      borderWidth: 3,
      // isOnlyText: true,
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kDefaultPadding)),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'See All',
            ),
          ),
        ],
      ),
    );
  }
}

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

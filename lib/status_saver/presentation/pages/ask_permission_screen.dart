import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/constants/constants.dart' show kPanelTransition;
import '../../../core/logs/logger.dart' show logs;
import '../../../main.dart';

class AskPermissionScreen extends StatelessWidget {
  const AskPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xEEEEEEEE),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: SvgPicture.asset(
              'assets/images/head.svg',
              fit: BoxFit.fill,
              height: height / 2,
            ),
          ),
          Positioned(
            top: height / 3,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: height / 2.5,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'setting',
                          child: Image.asset(
                            'assets/icons/icon.png',
                            height: height / 9,
                            width: height / 9,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status Saver',
                                style: TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                              Text('1.0.0',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black54)),
                              SizedBox(height: 12),
                              Text('Developer: Sadra Babai',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black45)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color(0x55000000),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Color(0xAAAA0000),
                                size: 48,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Status Saver App requires read and write permissions to function.',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Color(0x88000000),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (!await Permission.storage.isGranted) {
                                  logs.i('Ask for storage permission!');
                                  bool isGranted = await Permission.storage
                                      .request()
                                      .isGranted;
                                  logs.i(
                                    'Is storage permission isGranted: $isGranted',
                                  );
                                  if (isGranted) {
                                    navigateToHomeScreen(context);
                                  }
                                }
                              },
                              child: Text('Give Access'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            right: -30,
            child: SvgPicture.asset(
              'assets/images/setting.svg',
              fit: BoxFit.fill,
              color: Colors.black54,
              height: height / 4,
              width: height / 4,
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: SvgPicture.asset(
              'assets/images/side.svg',
              fit: BoxFit.fill,
              color: Color(0xff5ba781),
              height: height / 5,
              width: height / 5,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> navigateToHomeScreen(BuildContext buildContext) {
    return Navigator.pushReplacement(
      buildContext,
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: kPanelTransition,
        reverseTransitionDuration: kPanelTransition,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: MainApp(hasPermission: true),
          );
        },
      ),
    );
  }
}

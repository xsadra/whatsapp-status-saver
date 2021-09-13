import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
              //color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'setting',
                          child: Image.asset(
                            'assets/icons/icon.png',
                            height: height / 7,
                            width: height / 7,
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
                                  fontFamily: GoogleFonts.anton().fontFamily,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WhatsApp Status Saver App allows you to directly save WhatsApp Status of your friends into your gallery.',
                            style: TextStyle(
                              fontFamily: GoogleFonts.rajdhani().fontFamily,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Email us if you have any suggestions for improving the app, or if you encounter an error in the app. We read all your emails carefully and make changes.',
                            style: TextStyle(
                              fontFamily: GoogleFonts.rajdhani().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                          InkWell(
                            onTap: () => launch(
                                'mailto:wss@sadra.at?subject=From%20Status-Saver-app'),
                            child: Text(
                              'wss@sadra.at',
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 2,
                              ),
                            ),
                          )
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
}

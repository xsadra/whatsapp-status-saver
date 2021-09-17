import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_status_saver/status_saver/presentation/pages/pages.dart';

import '../../../../core/constants/constants.dart'
    show kDefaultPadding, kHeaderHeight, kPanelTransition;
import '../../../data/models/models.dart';
import '../../bloc/medias/bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/images/svg_flower.svg',
            height: 160,
            color: Color(0x66FF8F00),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: RotatedBox(
            quarterTurns: 2,
            child: SvgPicture.asset(
              'assets/images/svg_b.svg',
              width: width * 0.65,
              color: Color(0x7605CF08),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: SvgPicture.asset(
            'assets/images/svg_tl.svg',
            height: 70,
            color: Color(0x99FF0109),
          ),
        ),
        Positioned(
          bottom: -10,
          left: -50,
          child: RotatedBox(
            quarterTurns: 2,
            child: SvgPicture.asset(
              'assets/images/svg_t.svg',
              width: width * 0.95,
              color: Color(0x660F8F8F),
            ),
          ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x11ebebeb),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kDefaultPadding),
                bottomRight: Radius.circular(kDefaultPadding),
              ),
            ),
            height: kHeaderHeight,
            //color: Colors.black12,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 70.0),
                      child: Text(
                        "Status Saver",
                        style: GoogleFonts.anton(
                          fontSize: 40,
                          letterSpacing: 2,
                          color: Color(0xBB000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 14,
          child: BlocBuilder<MediasBloc, MediasState>(
            buildWhen: (previous, current) =>
                previous != current && current.state is Loaded,
            builder: (context, state) {
              if (state is Loaded) {
                var toShow = state.accountToShow;

                return Row(
                  children: [
                    for (AccountType account in state.accounts)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          // color: const Color(0xFF4C0050),
                          border: account.isOf(toShow)
                              ? Border(
                                  bottom: BorderSide(
                                      width: 4, color: Colors.black26))
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: InkWell(
                            onTap: () =>
                                context.read<MediasBloc>().add(GetAccountMedias(
                                      setAccountToShow: account,
                                    )),
                            child: Image.asset(
                              account.isOf(toShow)
                                  ? account.imagePath
                                  : account.saturatedImagePath,
                              width: account.isOf(toShow) ? 36 : 40,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        Positioned(
          top: 16,
          right: 10,
          child: GestureDetector(
            onTap: () {
              navigateToSettingScreen(context);
            },
            child: Hero(
              tag: 'setting',
              child: Icon(
                Icons.more_vert,
                size: 40,
                color: Color(0xBB000000),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> navigateToSettingScreen(BuildContext buildContext) {
    return Navigator.push(
      buildContext,
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionDuration: kPanelTransition,
        reverseTransitionDuration: kPanelTransition,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: SettingScreen(),
          );
        },
      ),
    );
  }
}

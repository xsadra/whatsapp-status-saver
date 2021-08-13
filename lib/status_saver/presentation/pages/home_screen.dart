import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/mock_data.dart' show MockData;
import '../controllers/home_controller.dart' show HomeController, HomeState;
import '../widgets/widgets.dart' show HomeHeader, HomeLongList, HomeShortList;
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final controller = HomeController();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onVerticalDragUpdate: _onVerticalGesture,
          child: Container(
            color: Color(0xffebebeb),
            // color: Colors.red,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        buildHomeBody(constraints),
                        buildShortAndLongList(constraints),
                        buildCloseLongLIstButton(constraints),
                        buildHeaderSection(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  AnimatedPositioned buildHomeBody(BoxConstraints constraints) {
    return AnimatedPositioned(
      duration: kPanelTransition,
      top: controller.homeState == HomeState.normal
          ? kHeaderHeight
          : -(constraints.maxHeight - kCartBarHeight * 2 - kHeaderHeight),
      right: 0,
      left: 0,
      height: constraints.maxHeight - kHeaderHeight - kCartBarHeight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(kDefaultPadding * 1.5),
            bottomRight: Radius.circular(kDefaultPadding * 1.5),
          ),
        ),
        child: GridView.builder(
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: MockData.mockPicsPaths.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: kDefaultPadding / 2,
            crossAxisSpacing: kDefaultPadding / 2,
          ),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      fullscreenDialog: true,
                      // barrierColor: Colors.transparent,
                      transitionDuration: kPanelTransition,
                      reverseTransitionDuration: kPanelTransition,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FadeTransition(
                        opacity: animation,
                        child: DetailsScreen(
                          height: constraints.maxHeight * 0.90,
                          onSave: () {
                            controller.addToSaveList(
                              MockData.mockPicsPaths[index],
                            );
                          },
                          path: MockData.mockPicsPaths[index],
                        ),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: MockData.mockPicsPaths[index],
                  child: CircleAvatar(
                    backgroundImage: AssetImage(MockData.mockPicsPaths[index]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AnimatedPositioned buildShortAndLongList(BoxConstraints constraints) {
    return AnimatedPositioned(
      duration: kPanelTransition,
      bottom: 0,
      right: 0,
      left: 0,
      height: controller.homeState == HomeState.normal
          ? kCartBarHeight
          : constraints.maxHeight - kCartBarHeight - 50,
      child: GestureDetector(
        onVerticalDragUpdate: _onVerticalGesture,
        child: Container(
          color: Color(0xffebebeb),
          alignment: Alignment.topLeft,
          child: AnimatedSwitcher(
            duration: kPanelTransition,
            child: controller.homeState == HomeState.normal
                ? HomeShortList(controller: controller)
                : HomeLongList(controller: controller),
          ),
        ),
      ),
    );
  }

  AnimatedPositioned buildCloseLongLIstButton(BoxConstraints constraints) {
    return AnimatedPositioned(
      duration: kPanelTransition,
      top: controller.homeState == HomeState.normal
          ? constraints.maxHeight
          : kCartBarHeight,
      left: controller.homeState == HomeState.normal ? 500 : 0,
      right: 0,
      height: 40,
      child: IconButton(
        tooltip: 'Close',
        onPressed: () {
          controller.changeHomeState(HomeState.normal);
        },
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 40,
        ),
        color: Colors.black87,
      ),
    );
  }

  AnimatedPositioned buildHeaderSection() {
    return AnimatedPositioned(
      duration: kPanelTransition,
      top: controller.homeState == HomeState.normal ? 0 : -kHeaderHeight,
      right: 0,
      left: 0,
      height: kHeaderHeight,
      child: HomeHeader(),
    );
  }
}

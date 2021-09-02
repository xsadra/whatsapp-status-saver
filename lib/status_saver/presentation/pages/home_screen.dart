import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../data/models/models.dart';
import '../bloc/medias/bloc.dart';
import '../bloc/saved_medias/bloc.dart' as saved;
import '../controllers/home_controller.dart' show HomeController, HomeState;
import '../widgets/widgets.dart'
    show HomeGridView, HomeHeader, HomeLongList, HomeShortList;

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
    return BlocListener<saved.SavedMediasBloc, saved.SavedMediasState>(
      listener: (context, state) {
        if (state is saved.Loaded) {
          SavedMedias savedMedias = state.savedMedias;
          if (savedMedias.hasItem) {
            controller.initPaths(savedMedias.getUris);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: GestureDetector(
            onVerticalDragUpdate: _onVerticalGesture,
            child: Container(
              color: Color(0xffebebeb),
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
        child: BlocBuilder<MediasBloc, MediasState>(
          buildWhen: (previous, current) =>
              previous != current &&
              current.state is! Saved &&
              current.state is! Saving,
          builder: (context, state) {
            if (state is Loaded) {
              final List<Uri> whatsAppImages = state.images;

              return HomeGridView(
                  images: whatsAppImages,
                  controller: controller,
                  constraints: constraints);
            } else if (state is Loading || state is Empty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Error) {
              print(state.message);
            }
            return Center(
              child: Text('Unhandled state'),
            );
          },
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

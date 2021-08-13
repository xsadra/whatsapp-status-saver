import 'package:flutter/foundation.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;
  List<String> paths = [];

  void changeHomeState(HomeState state) {
    homeState = state;
    notifyListeners();
  }

  void addToSaveList(String path) {
    for (String savedPath in paths) {
      if (path == savedPath) {
        notifyListeners();
        return;
      }
    }
    paths.add(path);
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

enum HomeState { normal, cart }

class HomeController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;
  List<Uri> paths = [];

  void changeHomeState(HomeState state) {
    homeState = state;
    notifyListeners();
  }

  void addToSaveList(Uri path) {
    for (Uri savedPath in paths) {
      if (path == savedPath) {
        notifyListeners();
        return;
      }
    }
    paths.add(path);
    notifyListeners();
  }

  void initPaths(List<Uri> uris) {
    for (var uri in uris) {
      paths.add(uri);
    }
    notifyListeners();
  }
}

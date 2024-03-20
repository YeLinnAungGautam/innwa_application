import "package:flutter/material.dart";

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      "........--------${route is ModalRoute}------this is test route ${route.isCurrent}------------$route----------------------------......",
    );
    if (route is ModalRoute && route.isCurrent) {
      final key = (route.settings).name;
      debugPrint("Go to route -> $key");
    } else {
      final key = (previousRoute?.settings as MaterialPage?);
      final valueKey = key?.key as ValueKey<String>?;
      debugPrint("Go to route -> ${valueKey?.value}");
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stockcry/app_route.dart';
import 'package:stockcry/modules/history/history_module.dart';
import 'package:stockcry/modules/home/home_module.dart';
import 'package:stockcry/modules/home/home_route.dart';

class RouteUtils {
  static void _goNextPage(
      {required String routeName,
      Object? args,
      bool isReplace = false,
      bool isReplaceAll = false}) {
    if (args == null) {
      if (isReplace) {
        Modular.to.navigate(routeName);
      } else if (isReplaceAll) {
        Modular.to.pushNamedAndRemoveUntil(
            routeName, (Route<dynamic> route) => false);
      } else {
        Modular.to.pushNamed(routeName);
      }
    } else {
      if (isReplace) {
        Modular.to.navigate(routeName, arguments: args);
      } else if (isReplaceAll) {
        Modular.to.pushNamedAndRemoveUntil(
            routeName, (Route<dynamic> route) => false);
      } else {
        Modular.to.pushNamed(routeName, arguments: args);
      }
    }
  }


  // Home Module
  static void goPageInHomeModule(
      {required String routeName, Object? args, bool? isReplace}) {
    _goNextPage(
        routeName: "${AppRoutes.home}$routeName",
        args: args,
        isReplace: isReplace ?? false);
  }


  // Change Route
  static void changeRoute<M extends Module?>(String? route,
      {Object? args, bool? isReplace, bool? isReplaceAll}) {
    // assert(M);
    String tempRoute = "";
    switch (M) {
      case HomeModule:
        tempRoute = AppRoutes.home;
        break;
      case HistoryModule:
        tempRoute = AppRoutes.home + HomeRoute.history;
        break;
    }
    _goNextPage(
        routeName: "$tempRoute$route",
        args: args,
        isReplace: isReplace ?? false,
        isReplaceAll: isReplaceAll ?? false);
  }
}

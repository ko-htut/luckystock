import 'package:flutter/material.dart';
import 'package:stockcry/modules/home/home_module.dart';
import 'package:stockcry/modules/home/home_route.dart';
import 'package:stockcry/utils/route_utils.dart';

class SplashWidget extends StatefulWidget {
const  SplashWidget({Key? key}) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    checkRoute();
  }

  void checkRoute() {
    Future.delayed(const Duration(microseconds: 1500)).then(
      (value) => RouteUtils.changeRoute<HomeModule>(
        HomeRoute.root,
        isReplace: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          //
          // Center(
          //     child: Image.asset(
          //   "assets/logo/logo_size-removebg-preview.png",
          //   width: MediaQuery.of(context).size.width / 2.5,
          // ))
        ],
      ),
    );
  }
}

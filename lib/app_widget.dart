// ignore_for_file: avoid_unnecessary_containers, unnecessary_this
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'error/unexpect_error_widget.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setErrorBuilder() {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return UnexpectErrorWidget(errorDetails: errorDetails);
    };
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    setErrorBuilder();
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      builder: (BuildContext context, widget) {
        setErrorBuilder();
        return widget!;
      },
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
          // brightness: Brightness.light,
          splashColor: Colors.transparent,
          tooltipTheme: const TooltipThemeData(verticalOffset: -100000),
          primaryColor: const Color(0xffffffff),
          primaryColorLight: Colors.white,
          textTheme: TextTheme(
              button: const TextStyle(
            fontSize: 45,
          ).apply(fontFamily: 'std')),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xffffffff),
            // primarySwatch:   Colors.white,
          )),
    );
  }
}

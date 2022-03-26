import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:stockcry/error/error_widget.dart';
import 'package:stockcry/modules/home/home_module.dart';
import 'package:stockcry/modules/splash/splash_widget.dart';
import 'app_route.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind((i) => Logger(printer: PrettyPrinter(methodCount: 0))),
    Bind((i) => FirebaseAnalytics.instance),
    // Bind((i) => RemoteConfig.instance),
    // Bind((i) => HomeRepositoryImpl.instance),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.root, child: (_, __) => const SplashWidget()),
    ModuleRoute(
      AppRoutes.home,
      module: HomeModule(),
    ),
    WildcardRoute(
        child: (_, args) => const ErrorWidget(
              errorMessage: '404 Route not found',
              isEmpty: true,
            )),
  ];
}

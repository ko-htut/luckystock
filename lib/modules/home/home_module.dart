import 'package:flutter_modular/flutter_modular.dart';
import 'package:stockcry/modules/history/history_module.dart';
import 'package:stockcry/modules/home/home_route.dart';
import 'package:stockcry/modules/home/widget/home_widget.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    //
  ];
  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(HomeRoute.root, child: (_, __) => const HomeWidget()),
    ModuleRoute(
      HomeRoute.history,
      module: HistoryModule(),
    ),
  ];
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:stockcry/modules/history/history_route.dart';
import 'package:stockcry/modules/history/widget/five_days_history.dart';
import 'package:stockcry/modules/history/widget/history_widget.dart';

class HistoryModule extends Module {
  @override
  final List<Bind> binds = [
    //
  ];
  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(HistoryRoute.root, child: (_, __) => const HistoryWidget()),
    ChildRoute(HistoryRoute.fivedayshistory,
        child: (_, __) => FiveDaysHistory())
  ];
}

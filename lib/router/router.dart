import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/view/screens/networkScanScreen/network_scan.screen.dart';

import '../view/screens/homeScreen/home.screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: Routes.root,
        ),
        AutoRoute(
          page: NetworkScanRoute.page,
          path: Routes.networkScan,
        ),
      ];
}

class Routes {
  static const String root = "/";
  static const String networkScan = "/networkScan";
}

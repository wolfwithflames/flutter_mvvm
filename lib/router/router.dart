import 'package:auto_route/auto_route.dart';

import '../view/screens/homeScreen/home.screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: "/",
        ),
      ];
}

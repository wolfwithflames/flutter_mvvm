// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(key: args.key),
      );
    },
    NetworkScanRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkScanRouteArgs>(
          orElse: () => const NetworkScanRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NetworkScanScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [NetworkScanScreen]
class NetworkScanRoute extends PageRouteInfo<NetworkScanRouteArgs> {
  NetworkScanRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          NetworkScanRoute.name,
          args: NetworkScanRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'NetworkScanRoute';

  static const PageInfo<NetworkScanRouteArgs> page =
      PageInfo<NetworkScanRouteArgs>(name);
}

class NetworkScanRouteArgs {
  const NetworkScanRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'NetworkScanRouteArgs{key: $key}';
  }
}

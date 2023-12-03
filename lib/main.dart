import 'package:flutter/material.dart';

import 'router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final rootRouter = AppRouter();

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: rootRouter.config(),
      builder: (_, router) {
        return router ?? const FlutterLogo();
      },
    ),
  );
}

// Router :  https://pub.dev/packages/go_router

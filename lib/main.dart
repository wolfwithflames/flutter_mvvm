import 'package:flutter/material.dart';
import 'package:network_tools_flutter/network_tools_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDirectory = await getApplicationDocumentsDirectory();

  await configureNetworkTools('build', enableDebugging: true);

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

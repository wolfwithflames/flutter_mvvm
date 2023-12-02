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
      // initialRoute: HomeScreen.id,
      // routes: {
      //   HomeScreen.id: (context) => const HomeScreen(),
      //   UserDetailsScreen.id: (context) => UserDetailsScreen(
      //       ModalRoute.of(context)!.settings.arguments as User),
      // },
    ),
  );
}


// Router :  https://pub.dev/packages/go_router
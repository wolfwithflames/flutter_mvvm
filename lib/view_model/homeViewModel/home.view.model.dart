import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/router.dart';

class HomeVM extends ChangeNotifier {
  void onNetworkScanButtonPressed(BuildContext context) {
    AutoRouter.of(context).pushNamed(Routes.networkScan);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/utils/logger.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:network_tools_flutter/network_tools_flutter.dart';

class UserVM extends ChangeNotifier {
  // final _myRepo = UserRepo();

  // ApiResponse<UserModel> userModel = ApiResponse.loading();
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<ActiveHost>? fetchedDevice;

  /// Starts a listener to scan for active hosts on the network.
  ///
  /// Example Usage:
  /// ```dart
  /// final userVM = UserVM();
  /// await userVM.startListener();
  /// ```
  ///
  /// Inputs: None
  ///
  /// Flow:
  /// 1. Get the WiFi IP address using `NetworkInfo().getWifiIP()`.
  /// 2. Extract the subnet by removing the last octet from the WiFi IP address.
  /// 3. Create a stream of pingable devices on the network using `HostScanner.getAllPingableDevices()` with the subnet, first host ID, last host ID, and a progress callback.
  /// 4. Initialize an empty list called `fetchedDevice`.
  /// 5. Listen to the stream of hosts and perform the following actions for each host:
  ///    - Log the progress of host discovery.
  ///    - Find the index where the host should be inserted in the `fetchedDevice` list using the `findIndexToInsert()` method.
  ///    - Insert the host at the determined index in the `fetchedDevice` list.
  ///    - Insert the host at the determined index in the `listKey` AnimatedListState.
  ///    - Notify the listeners of the `UserVM` class.
  /// 6. Log that the scan has completed when the stream is done.
  ///
  /// Outputs: None
  Future<void> startListener() async {
    final wifiIP = await NetworkInfo().getWifiIP();
    final String subnet = wifiIP!.substring(0, wifiIP.lastIndexOf('.'));
    final stream = HostScanner.getAllPingableDevices(subnet,
        firstHostId: 1, lastHostId: 254, progressCallback: (progress) {
      AppLog.i('Progress for host discovery : $progress');
    });

    fetchedDevice = [];

    stream.listen((host) async {
      //Same host can be emitted multiple times
      //Use Set<ActiveHost> instead of List<ActiveHost>
      AppLog.i('Found device: $host');
      int index = findIndexToInsert(host);
      fetchedDevice!.insert(index, host);
      listKey.currentState
          ?.insertItem(index, duration: const Duration(milliseconds: 500));

      notifyListeners();
    }, onDone: () {
      AppLog.i('Scan completed');
    });
  }

  void refreshList() {
    fetchedDevice = null;
    startListener();
    notifyListeners();
  }

  /// Finds the index where a new element should be inserted into the [fetchedDevice] list.
  ///
  /// The [newElement] parameter represents the element that needs to be inserted into the list.
  ///
  /// Returns the index where the new element should be inserted.
  int findIndexToInsert(ActiveHost newElement) {
    int indexToInsert = fetchedDevice!.indexWhere((element) =>
        int.parse(newElement.address.replaceAll(".", ""))
            .compareTo(int.parse(element.address.replaceAll(".", ""))) <
        0);
    if (indexToInsert == -1) {
      indexToInsert = fetchedDevice!.length;
    }
    return indexToInsert;
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/view/shared/my.text.view.dart';

import '../../../view_model/homeViewModel/home.view.model.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  HomeScreen({Key? key}) : super(key: key);

  final HomeVM viewModel = HomeVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: MyTextView(label: 'Home')),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _startListenerButton(context),
    );
  }

  Widget _startListenerButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => viewModel.onNetworkScanButtonPressed(context),
        child: const Text("Scan network"),
      ),
    );
  }
}
// switch (viewModel.userModel.status) {
//   case ApiStatus.loading:
//     return const LoadingWidget();
//   case ApiStatus.error:
//     return MyErrorWidget(viewModel.userModel.message ?? "NA");
//   case ApiStatus.completed:
//     return _getUsersListView(viewModel.userModel.data?.users);
//   default:
// }
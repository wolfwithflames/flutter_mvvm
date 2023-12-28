import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/view/shared/my.error.widget.dart';
import 'package:provider/provider.dart';

import '../../../view_model/userViewModel/user.view.model.dart';
import '../../shared/my.text.view.dart';

@RoutePage()
class NetworkScanScreen extends StatelessWidget {
  NetworkScanScreen({super.key});

  final UserVM viewModel = UserVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: MyTextView(label: 'Network devices')),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: viewModel.refreshList,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ChangeNotifierProvider<UserVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<UserVM>(
          builder: (context, viewModel, _) {
            if (viewModel.fetchedDevice == null) {
              return _startListenerButton();
            }
            if (viewModel.fetchedDevice!.isEmpty) {
              return const MyErrorWidget("No device found");
            }
            if (viewModel.fetchedDevice!.isNotEmpty) {
              return _productList();
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _startListenerButton() {
    return Center(
      child: TextButton(
        onPressed: viewModel.startListener,
        child: const Text("Start scanning"),
      ),
    );
  }

  Widget _productList() {
    return AnimatedList(
      key: viewModel.listKey,
      initialItemCount: viewModel.fetchedDevice?.length ?? 0,
      itemBuilder: (context, index, animation) {
        final product = viewModel.fetchedDevice?[index];
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: ListTile(
            title: Text(product!.address),
            subtitle: FutureBuilder<String?>(
              future: product.hostName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return Text(snapshot.data ?? "");
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}

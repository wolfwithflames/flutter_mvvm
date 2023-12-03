import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/userViewModel/user.view.model.dart';
import '../../shared/my.error.widget.dart';
import '../../shared/my.text.view.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserVM viewModel = UserVM();

  @override
  void initState() {
    // viewModel.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: MyTextView(label: 'Test')),
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
            // switch (viewModel.userModel.status) {
            //   case ApiStatus.loading:
            //     return const LoadingWidget();
            //   case ApiStatus.error:
            //     return MyErrorWidget(viewModel.userModel.message ?? "NA");
            //   case ApiStatus.completed:
            //     return _getUsersListView(viewModel.userModel.data?.users);
            //   default:
            // }
            if (viewModel.fetchedDevice == null) {
              return _startListenerButton();
            }
            if (viewModel.fetchedDevice!.isEmpty) {
              return const MyErrorWidget("No products fetched");
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
        child: const Text("Fetch Products"),
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

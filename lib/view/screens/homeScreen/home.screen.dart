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
            if (viewModel.fetchedProducts == null) {
              return _startListenerButton();
            }
            if (viewModel.fetchedProducts!.isEmpty) {
              return const MyErrorWidget("No products fetched");
            }
            if (viewModel.fetchedProducts!.isNotEmpty) {
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
        onPressed: viewModel.fetchProducts,
        child: const Text("Fetch Products"),
      ),
    );
  }

  Widget _productList() {
    return ListView.builder(
      itemCount: viewModel.fetchedProducts?.length,
      itemBuilder: (context, index) {
        final product = viewModel.fetchedProducts?[index];
        return ListTile(
          title: Text(product!.title ?? ""),
        );
      },
    );
  }
}

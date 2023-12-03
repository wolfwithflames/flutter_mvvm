import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvvm/models/product_model/product_model.dart';

import '../../utils/utils.dart';

class UserVM extends ChangeNotifier {
  // final _myRepo = UserRepo();

  // ApiResponse<UserModel> userModel = ApiResponse.loading();

  List<ProductModel>? fetchedProducts;

  // void _setUserMain(ApiResponse<UserModel> response) {
  //   userModel = response;
  //   notifyListeners();
  // }

  // Future<void> fetchUserData() async {
  //   _setUserMain(ApiResponse.loading());
  //   _myRepo
  //       .getUserData()
  //       .then((value) => _setUserMain(ApiResponse.completed(value)))
  //       .onError((error, stackTrace) =>
  //           _setUserMain(ApiResponse.error(error.toString())));
  // }

  StreamController<ProductModel> _listItemController =
      StreamController<ProductModel>.broadcast();

  Future<void> fetchProducts() async {
    _startListener();
    List<ProductModel> products = await Utils.getProducts();
    late Timer timer;
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      int randomInt = Random().nextInt(products.length);
      final toBeAddedProduct = products[randomInt];
      products.removeAt(randomInt);
      _listItemController.add(toBeAddedProduct);

      if (products.isEmpty) {
        timer.cancel();
        _listItemController.close();
      }
    });
  }

  void _startListener() {
    fetchedProducts = [];
    _listItemController.stream.listen((event) {
      fetchedProducts!.add(event);
      fetchedProducts!.sort(
          (a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()));
      notifyListeners();
    });
  }

  void refreshList() {
    fetchedProducts = null;
    notifyListeners();
    fetchProducts();
    _reOpen();
  }

  void _reOpen() {
    _listItemController = StreamController<ProductModel>.broadcast();
  }
}

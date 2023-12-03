import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mvvm/models/product_model/product_model.dart';

class Utils {
  static double setAverageRating() {
    return 10.3;
  }

  static Future<List<ProductModel>> getProducts() async {
    final String response = await rootBundle.loadString('assets/products.json');
    final data = await json.decode(response);

    return ((data as Map<String, dynamic>)["products"] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}

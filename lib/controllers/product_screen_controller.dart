import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:shopping/models/home_screen_model.dart';

class ProductDetailsScreenController with ChangeNotifier {
  ProductModel? product;
  bool isLoading = false;
  
  get http => null;

  getProductDetails(int productId) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse("https://fakestoreapi.com/products/$productId");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        product = ProductModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}

  

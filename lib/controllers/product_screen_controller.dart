import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/models/home_screen_model.dart';

class ProductScreenController with ChangeNotifier {
  bool isloading = false;
  List<ShoppingResModel> products = [];
  Future<void> getproduct() async {
    final url = Uri.parse("https://fakestoreapi.com/products");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        products = shoppingResModelFromJson(response.body);
      } else {
        print("Not loaded");
      }
    } catch (e) {
      print(e);
    }
  }
}

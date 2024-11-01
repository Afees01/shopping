import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  List categoryLst = [];
  bool isloading = false;
  int selectedCategoryIndex = 0;
  Future<void> getcategory() async {
    final url = Uri.parse("https://fakestoreapi.com/products/categories");
    try {
      isloading = true;
      notifyListeners();
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        var convertjson = jsonDecode(response.body);
        log(convertjson.toString());
        categoryLst = convertjson;
        categoryLst.insert(0, "All");
        print("list : $categoryLst");
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  oncategories() {}
  getAllproducts() {}
  getProductByCategories() {}
}

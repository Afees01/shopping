import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopping/models/home_screen_model.dart';
import 'package:sqflite/sqflite.dart';

class CartScreenController with ChangeNotifier {
  late Database database;
  Initdb() async {
    database = await openDatabase("cart.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, tittle TEXT, desc TEXT, qty TEXT,image TEXT)');
    });
  }

  getproduct() async {
    await database.rawQuery('SELECT * FROM cart');
    log();
  }

  addproduct(ProductModel selectedProduct) async {
    await database.rawInsert(
        'INSERT INTO Test(tittle, desc, qty, image) VALUES(?, ?, ?,?)', [
      selectedProduct.title,
      selectedProduct.description,
      1,
      selectedProduct.image
    ]);
  }
}

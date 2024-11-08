import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/controllers/cart_screen_controller.dart';
import 'package:shopping/controllers/home_screen_controller.dart';
import 'package:shopping/controllers/product_screen_controller.dart';
import 'package:shopping/view/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartScreenController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

import 'package:addtocard/card_screen.dart';
import 'package:addtocard/productlist_screen.dart';
import 'package:addtocard/wishlist_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
      routes: {
        '/cart': (context) => CartScreen(),
        '/wishlist': (context) => WishlistScreen(),
      },
    );
  }
}

import 'package:addtocard/productlist_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: ListView.builder(
          itemCount: CartService.cart.length,
          itemBuilder: (context, index) {
            final product = CartService.cart[index];
            return ListTile(
              title: Text(product.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeFromCart(context, product);
                },
              ),
            );
          },
        ),
      );
  }

  void _removeFromCart(BuildContext context, Product product) {
    setState(() {
      CartService.cart.remove(product);
    });
  }
}

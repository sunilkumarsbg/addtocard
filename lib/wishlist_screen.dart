import 'package:addtocard/productlist_screen.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: WishlistService.wishlist.length,
        itemBuilder: (context, index) {
          final product = WishlistService.wishlist[index];
          return ListTile(
            title: Text(product.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeFromWishlist(context, product);
              },
            ),
          );
        },
      ),
    );
  }

  void _removeFromWishlist(BuildContext context, Product product) {
    // setState(() {
    WishlistService.wishlist.remove(product);
    // });
  }
}





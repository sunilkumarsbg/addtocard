import 'dart:convert';
import 'package:addtocard/card_screen.dart';
import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;

  Product({required this.id, required this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'], name: json['name']);
  }
}

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    // Simulating fetching data from an API
    String jsonString =
        '[{"id":1,"name":"Product A"},{"id":2,"name":"Product B"},{"id":3,"name":"Product C"},{"id":4,"name":"Product D"}]';
    List<dynamic> jsonList = json.decode(jsonString);

    List<Product> products =
        jsonList.map((json) => Product.fromJson(json)).toList();

    return products;
  }
}

class CartService {
  static List<Product> cart = [];
}

class WishlistService {
  static List<Product> wishlist = [];
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      List<Product> fetchedProducts = await ProductService.fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      print('Error fetching products: $e');
    }
  }

  void _addToCart(Product product) {
    setState(() {
      CartService.cart.add(product);
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      CartService.cart.remove(product);
    });
  }

  void _addToWishlist(Product product) {
    setState(() {
      WishlistService.wishlist.add(product);
    });
  }

  void _removeFromWishlist(Product product) {
    setState(() {
      WishlistService.wishlist.remove(product);
    });
  }

  @override
  void dispose() {
    CartService.cart.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(product.name),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.pinkAccent,
                              ),
                              onPressed: () => _addToWishlist(product),
                            ),
                          ],
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          child: const Image(
                            image: NetworkImage(
                                'https://cdn.sportmonks.com/images/soccer/leagues/5.png'),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                                10), //this is causing the error, when I remove it, I get the card like on picture 2 with the red line
                          ),
                          width: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CartService.cart.length > 0
                                    ? ClipOval(
                                        child: Material(
                                          color: Colors.blue, // Button color
                                          child: InkWell(
                                            splashColor:
                                                Colors.red, // Splash color
                                            onTap: () {
                                              _addToCart(product);
                                            },
                                            child: const SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: Icon(Icons.add)),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  width: 10,
                                ),
                                CartService.cart.length > 0
                                    ? Text(CartService.cart.length.toString())
                                    : InkWell(
                                    onTap:(){
                                      _addToCart(product);
                                    } ,
                                    child: Text("Add")),
                                const SizedBox(
                                  width: 10,
                                ),
                                CartService.cart.length > 0
                                    ? ClipOval(
                                        child: Material(
                                          color: Colors.red, // Button color
                                          child: InkWell(
                                            splashColor:
                                                Colors.red, // Splash color
                                            onTap: () {
                                              _removeFromCart(product);
                                            },
                                            child: const SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: Icon(Icons.remove)),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
            child: const Icon(Icons.shopping_cart),
          ),
          Positioned(
            top: 15,
            right: 18,
            child: Transform.translate(
              offset: Offset(12, -12), // Adjust as needed
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors
                      .transparent, // You can change the background color as needed
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Center(
                  child: Text(
                    CartService.cart.length.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_provider_demo/providers/cart_provider.dart';
import 'package:flutter_provider_demo/repository.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _renderCartIcon() {
      return Container(
        width: 55,
        height: 60,
        child: IconButton(
          icon: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.shopping_cart),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                  child: Consumer<CartItemsProvider>(
                    // rerender when itmes added to cart or removed from cart
                    builder: (BuildContext _, CartItemsProvider provider,
                        Widget child) {
                      return Text(
                        // number of added items in cart
                        provider.cartItems.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => CartPage(),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          actions: [_renderCartIcon()],
        ),
        // consumer will detect provider changes and rerender the builder
        body: Consumer<CartItemsProvider>(
          builder:
              (BuildContext context, CartItemsProvider provider, Widget child) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext _, int index) {
                return ListTile(
                  title: Text(
                    items[index].name,
                  ),
                  trailing: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).buttonColor,
                    ),
                    child: IconButton(
                        color: Colors.white,
                        icon: Icon(
                            provider.cartItems.indexOf(items[index]) != -1
                                ? Icons.delete
                                : Icons.add),
                        onPressed: () => {
                              provider.cartItems.indexOf(items[index]) != -1
                                  // removing item from cart
                                  ? provider.removeItem(
                                      items[index],
                                    )
                                  // removing adding item to cart
                                  : provider.addToCart(
                                      items[index],
                                    ),
                            }),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

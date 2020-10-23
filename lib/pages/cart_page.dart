import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_demo/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Consumer<CartItemsProvider>(builder:
            (BuildContext context, CartItemsProvider provider, Widget child) {
          return ListView.builder(
              itemCount: provider.cartItems.length,
              itemBuilder: (BuildContext _, int index) {
                return ListTile(
                  title: Text(
                    provider.cartItems[index].name,
                  ),
                  trailing: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.delete_outline),
                      // removing item from cart
                      onPressed: () => provider.removeItem(
                        provider.cartItems[index],
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_provider_demo/models/item_model.dart';

class CartItemsProvider extends ChangeNotifier with DiagnosticableTreeMixin {
  List<Item> _cartItems = [];
  List<Item> get cartItems => _cartItems;
  void addToCart(Item item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  /// Makes `CartItemsProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('cart items', cartItems));
  }
}

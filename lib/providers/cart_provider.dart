import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(Map<String, dynamic> item) {
    final existingItemIndex =
        _cartItems.indexWhere((i) => i['name'] == item['name']);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex]['quantity'] += item['quantity'];
    } else {
      _cartItems.add(Map.from(item));
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get subtotal => _cartItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));
}

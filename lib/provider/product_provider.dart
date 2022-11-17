import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];

  void setProducts(List<Product> products) {
    products = products;
    notifyListeners();
  }

  void increaseQuantity(int id, bool isAdd) {
    if (isAdd) {
      products.map((e) {
        if (e.id == id) {
          e.quantity++;
        }
      }).toList();
    } else {
      products.map((e) {
        if (e.id == id) {
          e.quantity--;
        }
      }).toList();
    }
    notifyListeners();
  }

  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  void removeProduct(product) {
    products.remove(product);
    notifyListeners();
  }

  void clearProducts() {
    products = [];
    notifyListeners();
  }

  List<Product> getProducts() {
    return products;
  }
}

import 'dart:convert';
import 'package:ecommerce/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future getProducts({required int? limit}) async {
    var url = 'https://fakestoreapi.com/products?limit=$limit';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List productsJson = jsonDecode(response.body) as List;
      List<Product> productsList =
          productsJson.map((p) => Product.fromMap(p)).toList();
      return productsList;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

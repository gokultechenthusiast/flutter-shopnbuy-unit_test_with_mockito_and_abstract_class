import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/helpers/constants.dart';

abstract class API {
  Future<List<Product>> getProducts();
}

class HttpAPI implements API {
  static const endpoint = URL.ProductList;

  var client = new http.Client();

  @override
  Future<List<Product>> getProducts() async {
    var products = [];
    var response = await client.get(Uri.parse('$endpoint' + 'products.json'));

    var data = json.decode(response.body) as List<dynamic>;

    for (var product in data) {
      products.add(Product.fromJson(product));
    }

    return products;
  }
}

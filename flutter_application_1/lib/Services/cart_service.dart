import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/cart.dart';
import 'package:http/http.dart' as http;

class CartService {
  Future<Cart> postProductInCart(
      String price, int quantity, String print, String? user) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.cart),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'printing': print,
        'price': price.toString(),
        'quantity': quantity,
        'user': user,
      }),
    );
    if (response.statusCode == 201) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Categories from API');
    }
    // ignore: empty_catches
  }

  Future<List<Cart>?> getCartList() async {
    try {
      var url = Uri.parse(APIResponse.baseUrl + APIResponse.cart);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<Cart> results = [];
        jsonResponse.forEach((v) {
          results.add(Cart.fromJson(v));
        });
        print(results);
        return results;
      } else {
        throw Exception('Failed to load Categories from API');
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}

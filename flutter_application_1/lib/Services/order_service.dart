import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/order.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = const FlutterSecureStorage();

class OrderService {
  Future<Order> createOrder(
      String user,
      String billing_adress,
      String delivery_adress,
      List<String> printings,
      double final_price) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.order),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': user,
        'billing_adress': billing_adress,
        'delivery_adress': delivery_adress,
        'printings': printings,
        'final_price': final_price
      }),
    );
    if (response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user from API');
    }
    // ignore: empty_catches
  }
}

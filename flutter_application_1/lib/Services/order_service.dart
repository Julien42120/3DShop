import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/configuration.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = const FlutterSecureStorage();

class OrderService {
  Future<int> createOrder(String user, String billing_adress,
      String delivery_adress, double final_price) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.order),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'user': user,
        'billingAddress': billing_adress,
        'deliveryAddress': delivery_adress,
        'finalPrice': final_price
      }),
    );
    print(response);
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);

      int idOrder = (result['id']);
      return idOrder;
    } else {
      throw Exception('Failed to create user from API');
    }
    // ignore: empty_catches
  }

  Future<Configuration> createOrderConfigurate(String orders, String printing,
      String material, double priceProduct) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.orderPrintConfiguration),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'orders': orders,
        'printing': printing,
        'material': material,
        'priceProduct': priceProduct
      }),
    );
    if (response.statusCode == 201) {
      return Configuration.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user from API');
    }
    // ignore: empty_catches
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:http/http.dart' as http;

class ConfigService {
  Future<int> postConfig(String printing, String material) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.config),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'printing': printing,
        'material': material,
      }),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      int price = (result['new_price']);
      print(price);
      return price;
    } else {
      throw Exception('Erreur de Connexion');
    }
  }
}

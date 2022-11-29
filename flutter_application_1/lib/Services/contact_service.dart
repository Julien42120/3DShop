import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:http/http.dart' as http;

class ContactService {
  Future<String> postContact(String mail, String subject, String text) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.config),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mail': mail,
        'sujet': subject,
        'text': text,
      }),
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      String price = (result['new_price']).toString();
      print(price);
      return price;
    } else {
      throw Exception('Erreur de Connexion');
    }
  }
}

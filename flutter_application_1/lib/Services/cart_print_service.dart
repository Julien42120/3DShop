import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:http/http.dart' as http;

class CartService {
  Future<dynamic> postConfig(Print? printing, MaterialPrint? material) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.cartPrint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'printing': printing,
        'material': material,
      }),
    );
    print(response);
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception('Erreur de Configuration');
    }
    // ignore: empty_catches
  }
}

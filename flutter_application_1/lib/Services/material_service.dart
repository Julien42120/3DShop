import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/material.dart';
import 'package:http/http.dart' as http;

class MaterialService {
  Future<List<MaterialPrint>?> getMaterialList() async {
    try {
      var url = Uri.parse(APIResponse.baseUrl + APIResponse.material);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<MaterialPrint> results = [];
        jsonResponse.forEach((v) {
          results.add(MaterialPrint.fromJson(v));
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

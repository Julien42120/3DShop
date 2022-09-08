import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:http/http.dart' as http;

class PrintService {
  Future<List<Print>?> getPrintByCategory(String categoryId) async {
    try {
      var url = Uri.parse(
          APIResponse.baseUrl + APIResponse.categoryIdUrl + categoryId);
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = await json.decode(response.body);
        List<Print> results = [];
        jsonResponse['category'].forEach((v) {
          results.add(Print.fromJson(v));
        });
        print(results);
        return results;
      } else {
        throw Exception('Failed to load Print from API');
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  Future<Print?> getPrintById(String printId) async {
    try {
      var url =
          Uri.parse(APIResponse.baseUrl + APIResponse.printIdUrl + printId);
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = await json.decode(response.body);
        var result = jsonResponse['print'];
        print(result);
        return result;
      } else {
        throw Exception('Failed to load Print by id from API');
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}

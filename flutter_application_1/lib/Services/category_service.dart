import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<Category>?> getCategoriesList() async {
    try {
      var url = Uri.parse(APIResponse.baseUrl + APIResponse.categoriesUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<Category> results = [];
        jsonResponse['categories'].forEach((v) {
          results.add(Category.fromJson(v));
        });
        return results;
      } else {
        throw Exception('Failed to load Categories from API');
      }
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}

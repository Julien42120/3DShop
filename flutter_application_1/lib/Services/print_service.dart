import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/imagePrint.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = const FlutterSecureStorage();

class PrintService {
  Future<List<Print>> getPrintByCategory(String categoryId) async {
    var url =
        Uri.parse(APIResponse.baseUrl + APIResponse.categoryIdUrl + categoryId);
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
  }

  Future<Print> getPrintById(String printId) async {
    var token = await storage.read(key: 'token');
    var url = Uri.parse(APIResponse.baseUrl + APIResponse.printIdUrl + printId);
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await json.decode(response.body);
      var result = jsonResponse['print'];

      var printing = result[0];

      print(printing);
      return Print.fromJson(printing);
    } else {
      throw Exception('Failed to load Print by id from API');
    }
    // ignore: empty_catches
  }

  Future<List<ImagePrint>> getImagesPrint(String printId) async {
    var token = await storage.read(key: 'token');

    var url = Uri.parse(APIResponse.baseUrl + APIResponse.printIdUrl + printId);
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = await json.decode(response.body);
      List<ImagePrint> results = [];
      jsonResponse['images'].forEach((v) {
        results.add(ImagePrint.fromJson(v));
      });
      print(results);
      return results;
    } else {
      throw Exception('Failed to load Print from API');
    }
    // ignore: empty_catches
  }
}

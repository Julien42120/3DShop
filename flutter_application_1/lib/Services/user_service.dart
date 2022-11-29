import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/order.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
// Obtain shared preferences.
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<User> createUser(String email, String password, String avatar,
      String pseudo, String phone) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'avatar': avatar,
        'pseudo': pseudo,
        'phone': phone
      }),
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user from API');
    }
    // ignore: empty_catches
  }

  Future<dynamic> attemptToken(String email, String password) async {
    var response = await http.post(
      Uri.parse(APIResponse.baseUrl + APIResponse.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      var result = await jsonDecode(response.body);
      var token = result["token"];

      await storage.write(key: 'token', value: token);
      return result;
    } else {
      throw Exception('Erreur de Connexion');
    }
  }

  Future<User> accessProfile() async {
    var url = Uri.parse(APIResponse.baseUrl + APIResponse.profile);
    var token = await storage.read(key: 'token');

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(response);
    if (response.statusCode == 200) {
      var jsonResponse = await json.decode(response.body);
      var userResponse = jsonResponse['user'];
      var user = User.fromJson(userResponse);
      await storage.write(key: 'userName', value: user.pseudo);
      await storage.write(key: 'userAvatar', value: user.avatar);
      await storage.write(key: 'userID', value: user.id.toString());
      return user;
    } else {
      throw Exception('Failed to connect user'); // TO DO
    }
  }

  Future<List<Order>?> accessOrder() async {
    var token = await storage.read(key: 'token');
    var url = Uri.parse(APIResponse.baseUrl + APIResponse.profile);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(response);
    if (response.statusCode == 200) {
      var jsonResponse = await json.decode(response.body);
      List<Order> results = [];
      jsonResponse['order'].forEach((v) {
        results.add(Order.fromJson(v));
      });
      return results;
    } else {
      throw Exception('Failed to connect user');
    }
  }

  void logout() async {
    await storage.deleteAll();
    print(storage);
  }

  Future<User> modifyUser(String userId, String email, String password,
      String avatar, String pseudo, String phone) async {
    var token = await storage.read(key: 'token');
    var url = Uri.parse(APIResponse.baseUrl + APIResponse.modifyUser + userId);
    print(url);
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'avatar': avatar,
        'pseudo': pseudo,
        'phone': phone
      }),
    );
    print(response);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to connect user');
    }
  }
}

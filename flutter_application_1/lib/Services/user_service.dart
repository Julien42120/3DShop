import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
// Obtain shared preferences.

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
      var result = jsonDecode(response.body);
      print(result);
      await setToken(result['token']);
      return result;
    } else {
      throw Exception('Erreur de Connexion');
    }
    // ignore: empty_catches
  }

  Future<User> accessProfile() async {
    var response = await http.get(
      Uri.parse(APIResponse.baseUrl + APIResponse.profile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = await json.decode(response.body);
      var results = jsonResponse['user'];
      User.fromJson(results);
      return results;
    } else {
      throw Exception('Failed to connect user');
    }
    // ignore: empty_catches
  }

  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}

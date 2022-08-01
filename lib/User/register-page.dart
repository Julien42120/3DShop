// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Paiment/cart-page.dart';
import 'package:flutter_application_1/Product/list-categories-page.dart';
import 'package:flutter_application_1/User/log-in-page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0.5,
        overlayColor: Colors.black,
        spacing: 15,
        spaceBetweenChildren: 10,
        children: [
          SpeedDialChild(
              child: Icon(Icons.home),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryPage()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.shopping_cart),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 900,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 0, 17, 255),
              Color.fromARGB(255, 0, 0, 0),
            ],
          )),
          child: Container(
            margin: EdgeInsets.only(top: 90),
            child: Column(
              children: [
                Container(
                  child: const Text(
                    'Inscription',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Choix du pseudo',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Adresse mail ",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Mot de passe",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Confirmation mot de passe",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Choix d'une photo de profil",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ])),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInPage()),
                    );
                  },
                  child: Text("M'inscrire"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Paiment/cart-page.dart';
import 'package:flutter_application_1/Product/list-categories-page.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_application_1/User/register-page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

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
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Container(
                  child: const Text(
                    'Connexion',
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
                            labelText: 'Pseudo',
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
                    ])),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountPage()),
                    );
                  },
                  child: const Text("Me connecter"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Vous n'avez pas encore de compte ? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        const Text(
                          "Cliquez ici !",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

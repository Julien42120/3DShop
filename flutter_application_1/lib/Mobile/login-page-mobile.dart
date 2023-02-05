import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Mobile/account-page-mobile.dart';
import 'package:flutter_application_1/Services/order_service.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageMobile extends StatefulWidget {
  LoginPageMobile({Key? key}) : super(key: key);

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
  bool _isObscure = true;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  Future? _futureUser;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            matchTextDirection: true,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background.jpg'),
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(width * -0.4, height * 0.42),
        child: Transform.rotate(
          angle: pi / -3.7,
          child: Container(
            width: width * 1.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/back_green.png"),
              fit: BoxFit.contain,
            )),
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: CustomAppBarMobile(),
        body: Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Connexion',
                    style: GoogleFonts.kalam(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: _futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.05),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 400,
                                child: Column(
                                  children: [
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Entrez votre mail';
                                          }
                                          return null;
                                        },
                                        controller: _emailcontroller,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Email",
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            hoverColor: Colors.red),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Entrez votre mot de passe';
                                          }
                                          return null;
                                        },
                                        obscureText: _isObscure,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _passwordcontroller,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Mot de passe",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          suffixIcon: IconButton(
                                              icon: Icon(_isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Text(
                                          "Mot de passe oublié ?",
                                          style: GoogleFonts.kalam(
                                            fontSize: 14,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  var userService = UserService();
                                  await userService.attemptToken(
                                    _emailcontroller.text,
                                    _passwordcontroller.text,
                                  );
                                  var token =
                                      await storage.read(key: 'userConnected');
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccountPageMobile()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "L'un des champs contient une erreur",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 217, 81, 35),
                                      ),
                                    );
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Connexion réussie')),
                                    );
                                  }
                                },
                                child: Text(
                                  "Connexion",
                                  style: GoogleFonts.kalam(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
      )
    ]);
  }
}

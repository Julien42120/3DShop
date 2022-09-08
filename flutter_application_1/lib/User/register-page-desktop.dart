// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/User/log-in-page-desktop.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPageDesktop extends StatefulWidget {
  const RegisterPageDesktop({Key? key}) : super(key: key);

  @override
  State<RegisterPageDesktop> createState() {
    return _RegisterPageDesktopState();
  }
}

class _RegisterPageDesktopState extends State<RegisterPageDesktop> {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _avatarcontroller = TextEditingController();
  TextEditingController _pseudocontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();

  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 31, 31, 31)),
          child: AppBar(
            title: Center(
              child: Text(
                'Inscription',
                style: GoogleFonts.lobster(
                  fontSize: 35,
                ),
              ),
            ),
            actions: [
              OpenContainer<bool>(
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  transitionType: _transitionType,
                  transitionDuration: Duration(milliseconds: 1400),
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return LogInPageDesktop();
                  },
                  closedElevation: 0.0,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return Container(
                      margin: const EdgeInsets.only(right: 30, top: 20),
                      child: Text(
                        "J'ai déja un compte",
                        style: GoogleFonts.lobster(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }),
            ],
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            matchTextDirection: true,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.cover,
            image: AssetImage('assets/images/galaxy.png'),
          ),
        ),
        child: (_futureUser == null) ? buildForm() : buildFutureBuilder(),
      ),
    );
  }

  Container buildForm() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 400,
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        matchTextDirection: true,
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/image6.jpg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _pseudocontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Pseudo",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _emailcontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Adresse mail",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _phonecontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Numéro de téléphone",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _avatarcontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Choix d'une photo de profil",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(200),
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureUser = UserService().createUser(
                    _emailcontroller.text,
                    _passwordcontroller.text,
                    _avatarcontroller.text,
                    _pseudocontroller.text,
                    _phonecontroller.text,
                  );
                });
              },
              child: Text(
                "S'inscrire",
                style: GoogleFonts.lobster(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LogInPageDesktop();
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                matchTextDirection: true,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/galaxy.png'),
              ),
            ),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

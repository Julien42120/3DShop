// ignore_for_file: deprecated_member_use

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPageDesktop extends StatefulWidget {
  LogInPageDesktop({Key? key}) : super(key: key);

  @override
  State<LogInPageDesktop> createState() => _LogInPageDesktopState();
}

class _LogInPageDesktopState extends State<LogInPageDesktop> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  Future? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 31, 31, 31)),
          child: AppBar(
            title: Center(
              child: Text(
                'Connexion',
                style: GoogleFonts.lobster(
                  fontSize: 35,
                ),
              ),
            ),
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
        child: (_futureUser == null) ? buidLogin() : buildFutureBuilder(),
      ),
    );
  }

  Container buidLogin() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 400,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _emailcontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _passwordcontroller,
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
                  var userService = UserService();
                  _futureUser = userService.attemptToken(
                    _emailcontroller.text,
                    _passwordcontroller.text,
                  );
                });
              },
              child: Text(
                "Connexion",
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

  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('Réussi');
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

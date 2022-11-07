// ignore_for_file: deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
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
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Center(
              child: Container(
                margin: EdgeInsets.only(right: 50),
                child: DefaultTextStyle(
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TyperAnimatedText(
                        'Connexion',
                        speed: Duration(milliseconds: 230),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
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
              image: AssetImage('assets/images/background.jpg'),
            ),
          ),
          child: FutureBuilder(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Container(
                margin: EdgeInsets.only(top: 80),
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
                                    border: OutlineInputBorder(),
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.black),
                                    hoverColor: Colors.red),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextField(
                                controller: _passwordcontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Mot de passe",
                                  labelStyle: TextStyle(color: Colors.black),
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
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountPage()),
                          );
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
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}

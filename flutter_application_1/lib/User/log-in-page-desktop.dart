import 'dart:math';

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
  bool _isObscure = true;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  Future? _futureUser;

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
        offset: Offset(width * -0.15, height * 0.4),
        child: Transform.rotate(
          angle: pi / -3.5,
          child: Container(
            width: width * 0.5,
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
                    child: Text(
                      'Connexion',
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(
              top: height * 0.15,
            ),
            padding: const EdgeInsets.only(left: 30, right: 30),
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
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      hoverColor: Colors.red),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  obscureText: _isObscure,
                                  style: const TextStyle(color: Colors.black),
                                  controller: _passwordcontroller,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Mot de passe",
                                    labelStyle: TextStyle(color: Colors.black),
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
                          onPressed: () async {
                            var userService = UserService();
                            await userService.attemptToken(
                              _emailcontroller.text,
                              _passwordcontroller.text,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountPage()),
                            );
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
      )
    ]);
  }
}

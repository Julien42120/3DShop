import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/User/log-in-page-desktop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPageDesktop extends StatefulWidget {
  const RegisterPageDesktop({Key? key}) : super(key: key);

  @override
  State<RegisterPageDesktop> createState() {
    return _RegisterPageDesktopState();
  }
}

class _RegisterPageDesktopState extends State<RegisterPageDesktop> {
  bool _isObscure = true;
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _avatarcontroller = TextEditingController();
  final TextEditingController _pseudocontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  XFile? image;
  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  Future<User>? _futureUser;

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
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Center(
                child: Container(
                    margin: EdgeInsets.only(right: 60),
                    child: DefaultTextStyle(
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      child: const Text(
                        'Inscription',
                      ),
                    )),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            top: height * 0.12,
          ),
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: FutureBuilder<User>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LogInPageDesktop();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: TextField(
                                controller: _pseudocontroller,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Pseudo",
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextField(
                                controller: _emailcontroller,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Adresse mail",
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextField(
                                controller: _phonecontroller,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Numéro de téléphone",
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              //if user click this button, user can upload image from gallery
                              onPressed: () {
                                Navigator.pop(context);
                                getImage(ImageSource.gallery);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.image),
                                  Text('From Gallery'),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextField(
                                controller: _avatarcontroller,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Avatar",
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OpenContainer<bool>(
                            closedColor: Colors.transparent,
                            openColor: Colors.transparent,
                            transitionType: _transitionType,
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            openBuilder: (BuildContext _, openContainer) {
                              return LogInPageDesktop();
                            },
                            closedElevation: 0.0,
                            closedBuilder: (BuildContext _, openContainer) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(right: 30, top: 30),
                                child: Text(
                                  "J'ai déja un compte",
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }),
                        Container(
                          margin: const EdgeInsets.only(top: 30, right: 30),
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
                                    builder: (context) => LogInPageDesktop()),
                              );
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
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}

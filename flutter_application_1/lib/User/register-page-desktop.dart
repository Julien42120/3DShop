import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
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
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _avatarcontroller = TextEditingController();

  final TextEditingController _pseudocontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  // File? _image;

  // Future selectImage() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) return;

  //   final imagePath = File(image.path);
  //   setState(() {
  //     this._image = imagePath;
  //   });
  // }

  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          'Inscription',
                          speed: Duration(milliseconds: 230),
                        ),
                      ],
                    ),
                  )),
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
        child: (_futureUser == null) ? buildForm() : buildFutureBuilder(),
      ),
    );
  }

  Container buildForm() {
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
                    child: TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OpenContainer<bool>(
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  transitionType: _transitionType,
                  transitionDuration: const Duration(milliseconds: 600),
                  openBuilder: (BuildContext _, openContainer) {
                    return LogInPageDesktop();
                  },
                  closedElevation: 0.0,
                  closedBuilder: (BuildContext _, openContainer) {
                    return Container(
                      margin: const EdgeInsets.only(right: 30, top: 30),
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
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

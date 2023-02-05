import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/Tablet/account-page-desktop.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateUserMobile extends StatefulWidget {
  late String userId;
  final String email;
  final String password;
  final String avatar;
  final String pseudo;
  final String phone;

  UpdateUserMobile({
    Key? key,
    required this.userId,
    required this.email,
    required this.password,
    required this.avatar,
    required this.pseudo,
    required this.phone,
  }) : super(key: key);

  @override
  State<UpdateUserMobile> createState() {
    return _UpdateUserMobileState();
  }
}

class _UpdateUserMobileState extends State<UpdateUserMobile> {
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _avatarcontroller = TextEditingController();
  final TextEditingController _pseudocontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  UserService userService = UserService();
  late Future<User> _updateUser;
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = userService.accessProfile();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
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
          body: FutureBuilder<User>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.only(top: height * 0.15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Modification',
                          style: GoogleFonts.kalam(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.70,
                                margin: const EdgeInsets.only(top: 50),
                                child: TextField(
                                  controller: _pseudocontroller,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Pseudo",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.70,
                                margin: const EdgeInsets.only(top: 20),
                                child: TextField(
                                  controller: _emailcontroller,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Adresse mail",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.70,
                                margin: const EdgeInsets.only(top: 20),
                                child: TextField(
                                  controller: _phonecontroller,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Numéro de téléphone",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.70,
                                margin: const EdgeInsets.only(top: 20),
                                child: TextField(
                                  controller: _avatarcontroller,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Choix d'une photo de profil",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.70,
                                margin: const EdgeInsets.only(top: 20),
                                child: TextField(
                                  controller: _passwordcontroller,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Mot de passe",
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
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
                              _updateUser = userService.modifyUser(
                                  snapshot.data!.id.toString(),
                                  _emailcontroller.text,
                                  _passwordcontroller.text,
                                  _avatarcontroller.text,
                                  _pseudocontroller.text,
                                  _phonecontroller.text);
                            });
                          },
                          child: Text(
                            "Modifier",
                            style: GoogleFonts.kalam(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}

// ignore: file_names
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_application_1/User/log-in-page-desktop.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateUser extends StatefulWidget {
  late String userId;
  final String email;
  final String password;
  final String avatar;
  final String pseudo;
  final String phone;

  UpdateUser({
    Key? key,
    required this.userId,
    required this.email,
    required this.password,
    required this.avatar,
    required this.pseudo,
    required this.phone,
  }) : super(key: key);

  @override
  State<UpdateUser> createState() {
    return _UpdateUserState();
  }
}

class _UpdateUserState extends State<UpdateUser> {
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
                        'Modifier mes infos',
                        speed: Duration(milliseconds: 230),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [],
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
          child: FutureBuilder<User>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                                margin: const EdgeInsets.only(top: 70),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.pseudo),
                                    TextField(
                                      controller: _pseudocontroller,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Pseudo",
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
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
                                    labelText: "Choix d'une photo de profil",
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
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          )),
    );
  }
}

import 'dart:io';
import 'dart:math';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Mobile/login-page-mobile.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/Tablet/log-in-page-desktop.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class RegisterPageMobile extends StatefulWidget {
  const RegisterPageMobile({Key? key}) : super(key: key);

  @override
  State<RegisterPageMobile> createState() {
    return _RegisterPageMobileState();
  }
}

class _RegisterPageMobileState extends State<RegisterPageMobile> {
  bool _isObscure = true;
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _avatarcontroller = TextEditingController();
  final TextEditingController _pseudocontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  File? _image;
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  _imageFromCamera() async {
    var img = await picker.pickImage(source: ImageSource.camera);
    if (img == null) return;
    final imageTemporary = File(img.path);

    setState(() {
      _image = imageTemporary;
    });
  }

  _imageFromGallery() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    final imageTemporary = File(img.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  void _showPicker(contect) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galerie'),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Caméra'),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: height * 0.12,
            ),
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Inscription',
                    style: GoogleFonts.kalam(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                FutureBuilder<User>(
                  future: _futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return LogInPageDesktop();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return Form(
                      key: _formKey,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: SizedBox(
                                width: 400,
                                child: Column(
                                  children: [
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 50),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Entrez un pseudo';
                                          }
                                          return null;
                                        },
                                        controller: _pseudocontroller,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Pseudo",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Entrez un mail';
                                          }
                                          return null;
                                        },
                                        controller: _emailcontroller,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Adresse mail",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Entrez un n°';
                                          }
                                          return null;
                                        },
                                        controller: _phonecontroller,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Numéro de téléphone",
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: TextButton(
                                        onPressed: () {
                                          _showPicker(context);
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.camera,
                                                color: Colors.green,
                                              ),
                                              _image == null
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      child: const Text(
                                                        "Photo de profil",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    )
                                                  : Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      child: Flexible(
                                                          child: Text(
                                                        _image!.path,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Entrez un mot de passe';
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
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 15, right: 15),
                                  padding: EdgeInsets.only(top: 2, bottom: 2),
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPageMobile()),
                                        );
                                        setState(() {
                                          _futureUser =
                                              UserService().createUser(
                                            _emailcontroller.text,
                                            _passwordcontroller.text,
                                            _image!.path,
                                            _pseudocontroller.text,
                                            _phonecontroller.text,
                                          );
                                        });
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Inscription réussie')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "S'inscrire",
                                      style: GoogleFonts.kalam(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                OpenContainer<bool>(
                                    closedColor: Colors.transparent,
                                    openColor: Colors.transparent,
                                    transitionType: _transitionType,
                                    transitionDuration:
                                        const Duration(milliseconds: 600),
                                    openBuilder:
                                        (BuildContext _, openContainer) {
                                      return LoginPageMobile();
                                    },
                                    closedElevation: 0.0,
                                    closedBuilder:
                                        (BuildContext _, openContainer) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            right: 30, top: 30),
                                        child: Text(
                                          "J'ai déjà un compte",
                                          style: GoogleFonts.kalam(
                                            fontSize: 15,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

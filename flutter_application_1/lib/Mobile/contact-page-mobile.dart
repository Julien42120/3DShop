import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Tablet/list-categories-page-desktop.dart';
import 'package:flutter_application_1/Services/contact_service.dart';
import 'package:flutter_application_1/Tablet/log-in-page-desktop.dart';
import 'package:flutter_application_1/navBar-desktop.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPageMobile extends StatefulWidget {
  const ContactPageMobile({Key? key}) : super(key: key);

  @override
  State<ContactPageMobile> createState() {
    return _ContactPageMobileState();
  }
}

class _ContactPageMobileState extends State<ContactPageMobile> {
  final TextEditingController _mailcontroller = TextEditingController();
  final TextEditingController _subjectcontroller = TextEditingController();
  final TextEditingController _textcontroller = TextEditingController();

  Future<String>? _future;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
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
          offset: Offset(width * -0.15, height * 0.45),
          child: Transform.rotate(
            angle: pi / -3.5,
            child: Container(
              width: width * 1.9,
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
            scrollDirection: Axis.vertical,
            child: Container(
                margin: EdgeInsets.only(
                  top: height * 0.07,
                ),
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return LogInPageDesktop();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Container(
                      margin: EdgeInsets.only(top: height * 0.12),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Contact',
                              style: GoogleFonts.kalam(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.70,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              "Ici vous pouvez faire une demande à l'administrateur",
                              style: TextStyle(fontSize: 14),
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
                                      controller: _mailcontroller,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Votre mail",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.70,
                                    margin: const EdgeInsets.only(top: 20),
                                    child: TextField(
                                      controller: _subjectcontroller,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Le Sujet",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.70,
                                    margin: const EdgeInsets.only(top: 20),
                                    child: TextField(
                                      controller: _textcontroller,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Votre message",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 40, right: 20),
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
                                              builder: (context) =>
                                                  CategoryPageDesktop()),
                                        );
                                        setState(() {
                                          _future =
                                              ContactService().postContact(
                                            _mailcontroller.text,
                                            _subjectcontroller.text,
                                            _textcontroller.text,
                                          );
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: const Icon(
                                              Icons.send,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Text(
                                            "Envoyer",
                                            style: GoogleFonts.kalam(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ),
      ],
    );
  }
}

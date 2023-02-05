import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Tablet/list-categories-page-desktop.dart';
import 'package:flutter_application_1/Services/contact_service.dart';
import 'package:flutter_application_1/Tablet/log-in-page-desktop.dart';
import 'package:flutter_application_1/navBar-desktop.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPageDesktop extends StatefulWidget {
  const ContactPageDesktop({Key? key}) : super(key: key);

  @override
  State<ContactPageDesktop> createState() {
    return _ContactPageDesktopState();
  }
}

class _ContactPageDesktopState extends State<ContactPageDesktop> {
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
            preferredSize: Size.fromHeight(60),
            child: CustomAppBarDesktop(),
          ),
          body: Container(
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
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'Contact',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            "Ici vous pouvez faire une demande à l'administrateur",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 400,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  child: TextField(
                                    controller: _mailcontroller,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Votre mail",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: TextField(
                                    controller: _subjectcontroller,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Le Sujet",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: TextField(
                                    controller: _textcontroller,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Votre message",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 30, right: 30),
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
                                        _future = ContactService().postContact(
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
                                            fontSize: 25,
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
      ],
    );
  }
}

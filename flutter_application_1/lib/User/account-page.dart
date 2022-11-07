import 'package:accordion/accordion.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Category/list-categories-page-desktop.dart';
import 'package:flutter_application_1/Models/order.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/User/register-page-desktop.dart';
import 'package:flutter_application_1/User/update_user.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? _userModel;
  late List<Order>? _orderModel = [];
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  UserService userService = UserService();
  var i = 0;

  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = await userService.accessProfile();
    _orderModel = await userService.accessOrder();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
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
                      'Mon Profil',
                      speed: Duration(milliseconds: 230),
                    ),
                  ],
                ),
              ),
            )),
            actions: [
              OpenContainer<bool>(
                closedColor: Colors.transparent,
                openColor: Colors.transparent,
                transitionType: _transitionType,
                transitionDuration: Duration(milliseconds: 600),
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return CategoryPageDesktop();
                },
                closedElevation: 0.0,
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: const Icon(
                      Icons.home,
                      size: 40,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ],
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: _userModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    matchTextDirection: true,
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/background.jpg'),
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.center,
                            matchTextDirection: true,
                            repeat: ImageRepeat.noRepeat,
                            fit: BoxFit.cover,
                            image: NetworkImage(_userModel!.avatar),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text(
                              _userModel!.pseudo,
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 60,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: Accordion(
                        maxOpenSections: 1,
                        headerBackgroundColorOpened: Colors.black54,
                        headerPadding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 15),
                        children: [
                          AccordionSection(
                            isOpen: false,
                            leftIcon:
                                const Icon(Icons.list, color: Colors.white),
                            headerBackgroundColor: Colors.black,
                            headerBackgroundColorOpened:
                                Color.fromARGB(255, 0, 95, 0),
                            header: Text(
                              "Mes informations personelles",
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            content: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                          child: Text(
                                            'Mon mail :',
                                            style: GoogleFonts.robotoCondensed(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Center(
                                          child: Text(
                                            _userModel!.email,
                                            style: GoogleFonts.robotoCondensed(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        'Mon pseudo :',
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        _userModel!.pseudo,
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        'Mon numéro de téléphone :',
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        _userModel!.phone,
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        'Ma photo :',
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        _userModel!.avatar,
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                OpenContainer<bool>(
                                  transitionType: _transitionType,
                                  transitionDuration:
                                      Duration(milliseconds: 600),
                                  openBuilder: (BuildContext _,
                                      VoidCallback openContainer) {
                                    return UpdateUser(
                                      userId: _userModel!.id.toString(),
                                      email: _userModel!.email,
                                      password: _userModel!.password,
                                      avatar: _userModel!.avatar,
                                      pseudo: _userModel!.pseudo,
                                      phone: _userModel!.phone,
                                    );
                                  },
                                  closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    side: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  closedElevation: 0.0,
                                  closedBuilder: (BuildContext _,
                                      VoidCallback openContainer) {
                                    return Container(
                                      width: 200,
                                      child: Center(
                                        child: Text(
                                          'Modifier mes informations',
                                          style: GoogleFonts.robotoCondensed(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          AccordionSection(
                            isOpen: false,
                            leftIcon:
                                const Icon(Icons.list, color: Colors.white),
                            headerBackgroundColor: Colors.black,
                            headerBackgroundColorOpened:
                                Color.fromARGB(255, 0, 95, 0),
                            header: Text(
                              "Mes commandes",
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            content: Container(
                              child: SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: _orderModel!.length,
                                  itemBuilder: ((context, index) => Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Color.fromARGB(
                                                    255, 209, 209, 209)),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Center(
                                                child: Text('Commande n°' +
                                                    _orderModel!.length
                                                        .toString())),
                                            Column(
                                              children: [
                                                for (var i = 0;
                                                    i <
                                                        _orderModel![index]
                                                            .printing
                                                            .length;
                                                    i++)
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Container(
                                                          width: 150,
                                                          height: 70,
                                                          decoration:
                                                              const BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              matchTextDirection:
                                                                  true,
                                                              repeat:
                                                                  ImageRepeat
                                                                      .noRepeat,
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                  'assets/images/image6.jpg'),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7)),
                                                          ),
                                                        ),
                                                        Text(_orderModel![index]
                                                            .printing[i]
                                                            .title),
                                                        Text(_orderModel![index]
                                                                .printing[i]
                                                                .default_size
                                                                .toString() +
                                                            ' cm'),
                                                        Text(_orderModel![index]
                                                                .printing[i]
                                                                .default_weight
                                                                .toString() +
                                                            ' g'),
                                                        Text(_orderModel![index]
                                                            .billing_address),
                                                        Text(_orderModel![index]
                                                            .delivery_address),
                                                      ],
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          UserService().logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPageDesktop()),
                          );
                        },
                        child: Text(
                          "Déconnexion",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

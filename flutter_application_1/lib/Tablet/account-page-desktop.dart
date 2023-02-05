import 'package:accordion/accordion.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Mobile/login-page-mobile.dart';
import 'package:flutter_application_1/Models/configuration.dart';
import 'package:flutter_application_1/Tablet/list-categories-page-desktop.dart';
import 'package:flutter_application_1/Models/order.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/Tablet/log-in-page-desktop.dart';
import 'package:flutter_application_1/Tablet/update-user-desktop.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? _userModel;
  late List<Order>? _orderModel = [];
  late List<Configuration>? _orderConfig = [];

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

  void _getProductOfOrder(idOrder) async {
    _orderConfig = await userService.getProductOfOrder(idOrder);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Center(
                child: Container(
              margin: EdgeInsets.only(right: 60),
              child: DefaultTextStyle(
                style: GoogleFonts.kalam(
                  fontSize: 30,
                  color: Colors.black,
                ),
                child: const Text(
                  'Mon Profil',
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
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                        'Votre session a expirée merci de vous reconnecter'),
                  ),
                  TextButton(
                    onPressed: () async {
                      UserService().logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LogInPageDesktop()),
                      );
                    },
                    child: Text(
                      "Reconnexion",
                      style: GoogleFonts.kalam(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
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
                              style: GoogleFonts.kalam(
                                fontSize: 60,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height,
                      width: width * 0.7,
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
                              "Mes informations personnelles",
                              style: GoogleFonts.kalam(
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
                                            style: GoogleFonts.kalam(
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
                                            style: GoogleFonts.kalam(
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
                                        style: GoogleFonts.kalam(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        _userModel!.pseudo,
                                        style: GoogleFonts.kalam(
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
                                        style: GoogleFonts.kalam(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        _userModel!.phone,
                                        style: GoogleFonts.kalam(
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
                                        style: GoogleFonts.kalam(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        _userModel!.avatar,
                                        style: GoogleFonts.kalam(
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
                                    return UpdateUserDesktop(
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
                                          style: GoogleFonts.kalam(
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
                              style: GoogleFonts.kalam(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            content: SizedBox(
                              height: height * 0.5,
                              child: ListView.builder(
                                itemCount: _orderModel!.length,
                                itemBuilder: ((context, index) {
                                  _getProductOfOrder(
                                      _orderModel![index].id.toString());
                                  return Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Color.fromARGB(
                                                    255, 209, 209, 209)),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Commande n°" +
                                                  _orderModel![index]
                                                      .id
                                                      .toString(),
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const Text(
                                              "En cours d'envoi",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Adresse de facturation: ',
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Text(_orderModel![index]
                                                    .billingAddress),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Color.fromARGB(
                                                    255, 209, 209, 209)),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: height * 0.25,
                                          child: ListView.builder(
                                            itemCount: _orderConfig!.length,
                                            itemBuilder: ((context, i) {
                                              return Container(
                                                width: width * 0.7,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      height: height * 0.1,
                                                      width: width * 0.1,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          alignment:
                                                              Alignment.center,
                                                          matchTextDirection:
                                                              true,
                                                          repeat: ImageRepeat
                                                              .noRepeat,
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              _orderConfig![
                                                                      index]
                                                                  .printing
                                                                  .imagePrintings[
                                                                      0]
                                                                  .image),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(_orderConfig![i]
                                                        .printing
                                                        .title),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          _orderConfig![i]
                                                                  .material
                                                                  .type_name +
                                                              ": ",
                                                          style: GoogleFonts
                                                              .robotoCondensed(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text(_orderConfig![i]
                                                            .material
                                                            .color),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Prix: ",
                                                          style: GoogleFonts
                                                              .robotoCondensed(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text(_orderConfig![i]
                                                                .price_product
                                                                .toString() +
                                                            " € "),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Color.fromARGB(
                                                    255, 209, 209, 209)),
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Center(
                                            child: Text(
                                          'Total de la commande : ' +
                                              _orderModel![index]
                                                  .finalPrice
                                                  .toString() +
                                              " € ",
                                          style: GoogleFonts.robotoCondensed(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () async {
                          UserService().logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPageDesktop()),
                          );
                        },
                        child: Text(
                          "Déconnexion",
                          style: GoogleFonts.kalam(
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

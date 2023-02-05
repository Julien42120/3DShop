import 'package:accordion/accordion.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Mobile/list-categories-page-mobile.dart';
import 'package:flutter_application_1/Mobile/login-page-mobile.dart';
import 'package:flutter_application_1/Mobile/update-user-mobile.dart';
import 'package:flutter_application_1/Models/configuration.dart';
import 'package:flutter_application_1/Tablet/cart_screen-desktop.dart';
import 'package:flutter_application_1/Tablet/list-categories-page-desktop.dart';
import 'package:flutter_application_1/Models/order.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPageMobile extends StatefulWidget {
  AccountPageMobile({Key? key}) : super(key: key);

  @override
  State<AccountPageMobile> createState() => _AccountPageMobileState();
}

class _AccountPageMobileState extends State<AccountPageMobile> {
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

  _getProductOfOrder(idOrder) async {
    _orderConfig = await userService.getProductOfOrder(idOrder);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: CustomAppBarMobile(),
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
                            builder: (context) => LoginPageMobile()),
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
                        margin: const EdgeInsets.only(top: 100),
                        width: 150,
                        height: 150,
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
                      height: height * 0.5,
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
                                        'Mon n° de téléphone :',
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
                                OpenContainer<bool>(
                                  transitionType: _transitionType,
                                  transitionDuration:
                                      Duration(milliseconds: 600),
                                  openBuilder: (BuildContext _,
                                      VoidCallback openContainer) {
                                    return UpdateUserMobile(
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
                                      padding: EdgeInsets.all(10),
                                      width: 200,
                                      child: Center(
                                        child: Text(
                                          'Modifier mes informations',
                                          style: GoogleFonts.kalam(
                                            fontSize: 14,
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
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color: Color.fromARGB(
                                                    255, 209, 209, 209)),
                                          ),
                                        ),
                                        child: Column(
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
                                                      fontSize: 15,
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
                                                          fontSize: 15,
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
                                          child: _orderConfig == null
                                              ? CircularProgressIndicator()
                                              : ListView.builder(
                                                  itemCount:
                                                      _orderConfig!.length,
                                                  itemBuilder: ((context, i) {
                                                    return Container(
                                                      width: width * 0.7,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            height:
                                                                height * 0.1,
                                                            width: width * 0.2,
                                                            decoration:
                                                                BoxDecoration(
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
                                                                fit: BoxFit
                                                                    .cover,
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
                                                          Column(
                                                            children: [
                                                              Text(
                                                                  _orderConfig![
                                                                          i]
                                                                      .printing
                                                                      .title),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    _orderConfig![i]
                                                                            .material
                                                                            .type_name +
                                                                        ": ",
                                                                    style: GoogleFonts.robotoCondensed(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(_orderConfig![
                                                                          i]
                                                                      .material
                                                                      .color),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Prix: ",
                                                                    style: GoogleFonts.robotoCondensed(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(_orderConfig![
                                                                              i]
                                                                          .price_product
                                                                          .toString() +
                                                                      " € "),
                                                                ],
                                                              ),
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
                                builder: (context) => CategoryPageMobile()),
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

// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../Product/list-categories-page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0.5,
        overlayColor: Colors.black,
        spacing: 15,
        spaceBetweenChildren: 10,
        children: [
          SpeedDialChild(
              child: Icon(Icons.home),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryPage()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.person),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountPage()),
                );
              }),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 0, 17, 255),
            Color.fromARGB(255, 0, 0, 0),
          ],
        )),
        child: Column(
          children: [
            Center(
                child: Container(
                    margin: const EdgeInsets.all(30),
                    child: const Text(
                      'Mes produits',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
            Container(
              height: 500,
              child: ListView(
                children: [
                  for (var i = 0; i < 10; i++)
                    Container(
                      height: 170,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.centerLeft,
                          matchTextDirection: true,
                          repeat: ImageRepeat.noRepeat,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/image4.jpg'),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(125, 252, 252, 252),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Titre produit',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'PLA rouge , 20 cm',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      '65€',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              height: 105,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(122, 184, 184, 184),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Prix Total',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '144,55€',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: null,
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Passer commande",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

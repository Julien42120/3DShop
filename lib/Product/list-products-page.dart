import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Paiment/cart-page.dart';
import 'list-categories-page.dart';
import 'config-product-page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 0;
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
              child: Icon(Icons.shopping_cart),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (var i = 0; i < 6; i++)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfigProductPage()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        matchTextDirection: true,
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/image4.jpg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            child: const Text(
                              'Produit',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            child: const Text(
                              'A partir de :',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 125),
                        width: 130,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(174, 0, 0, 0),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 10),
                                  child: const Text(
                                    'Julien',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          matchTextDirection: true,
                                          repeat: ImageRepeat.noRepeat,
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/image4.jpg'),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)))),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, top: 15),
                              child: const Text(
                                'Litle description for explain my app flutter',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 45, top: 20),
                                  child: const Text(
                                    '10',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    height: 30,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        alignment: Alignment.center,
                                        matchTextDirection: true,
                                        repeat: ImageRepeat.noRepeat,
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/heart.png'),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

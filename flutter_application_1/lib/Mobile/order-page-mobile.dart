import 'dart:convert';
import 'dart:math';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Services/order_service.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderPageMobile extends StatefulWidget {
  List<Print> printing;
  OrderPageMobile({Key? key, required this.printing}) : super(key: key);

  @override
  State<OrderPageMobile> createState() => _OrderPageMobileState();
}

class _OrderPageMobileState extends State<OrderPageMobile> {
  bool _isObscure = true;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  TextEditingController _billing_adress_controller = TextEditingController();
  TextEditingController _delivery_adress_controller = TextEditingController();

  Future? _futureOrder;
  late Future<int> order;
  double? finalPrice;

  late String userId;
  late String stringPrice;
  // late User user;

  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    userId = (await UserService().storage.read(key: 'userID'))!;
    // user = await UserService().getUser(userId);
    userId = "api/users/" + userId;
    setState(() {});
  }

// défini la variable finalPrice pour l'envoi des données
  void getFinalPrice(val) {
    finalPrice = val;
  }

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
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.1),
                  child: Center(
                    child: Text(
                      'Récapitulatif',
                      style: GoogleFonts.kalam(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.3,
                  width: width * 0.9,
                  margin: EdgeInsets.only(top: height * 0.05),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(120, 142, 142, 142),
                            offset: Offset(0, 7),
                            blurRadius: 8,
                            spreadRadius: 3)
                      ]),
                  child: ListView.builder(
                    itemCount: widget.printing.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              //                   <--- left side
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: width * 0.3,
                              child: Text(
                                widget.printing[index].title,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: const Text(
                                    'Couleur :',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    widget.printing[index].default_material!
                                        .color,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                child: Text(
                                  widget.printing[index].price.toString() +
                                      ' €',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: width * 0.9,
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(120, 142, 142, 142),
                          offset: Offset(0, 7),
                          blurRadius: 8,
                          spreadRadius: 3)
                    ],
                  ),
                  child: FutureBuilder(
                    future: _futureOrder,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Consumer<ProductsVM>(
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                ValueNotifier<double> totalPrice =
                                    ValueNotifier(0);
                                for (var element in value.lst) {
                                  totalPrice.value =
                                      totalPrice.value + element.price;
                                }
                                return ValueListenableBuilder<double?>(
                                  valueListenable: totalPrice,
                                  builder: (context, val, child) {
                                    getFinalPrice(val);
                                    return Text(
                                      'Prix total : ' + val.toString() + ' €',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: width * 0.9,
                  child: const Text(
                    "Le choix d'un transporteur étant actuellement indisponible, le prix total contient les frais d'expédition",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
                Container(
                  width: width * 0.9,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _billing_adress_controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Adresse de facturation",
                              labelStyle: TextStyle(color: Colors.black),
                              hoverColor: Colors.red),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: _delivery_adress_controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Adresse de livraison",
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        order = OrderService().createOrder(
                            userId,
                            _billing_adress_controller.text,
                            _delivery_adress_controller.text,
                            finalPrice!);
                      });
                      int idOrder = await order;

                      for (var i = 0; i < widget.printing.length; i++) {
                        await OrderService().createOrderConfigurate(
                            APIResponse.pathOrderPostConfig +
                                idOrder.toString(),
                            APIResponse.pathPrintPostConfig +
                                widget.printing[i].id.toString(),
                            APIResponse.pathMaterialPostConfig +
                                widget.printing[i].default_material!.id
                                    .toString(),
                            widget.printing[i].price);
                      }
                      setState(() {
                        stringPrice = jsonEncode(finalPrice.toString());
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => UsePaypal(
                              sandboxMode: true,
                              clientId:
                                  "AUb03q9weYrUDOqyYADKAm6L6e1zdn2C77TEZ9gJxDQSnumTyA0T9dkVSVlkD8qlh9Diwr0nPYjny3ul",
                              secretKey:
                                  "EL5PQxDpS4dF9EejRUbzZrZB5xxi2St6ksIUbunf9g1OYgf5ouGOg7v5UormcZxSmCwYq92zAdZ9Rlii",
                              returnURL: "https://samplesite.com/return",
                              cancelURL: "https://samplesite.com/cancel",
                              transactions: const [
                                {
                                  "amount": {
                                    "total": '10',
                                    "currency": "EUR",
                                    "details": {
                                      "subtotal": '10',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "A demo product",
                                        "quantity": 1,
                                        "price": "10.12",
                                        "currency": "USD"
                                      }
                                    ],

                                    // shipping address is not required though
                                    "shipping_address": {
                                      "recipient_name": "Jane Foster",
                                      "line1": "Travis County",
                                      "line2": "",
                                      "city": "Austin",
                                      "country_code": "US",
                                      "postal_code": "73301",
                                      "phone": "+00000000",
                                      "state": "Texas"
                                    },
                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                print("onSuccess: $params");
                              },
                              onError: (error) {
                                print("onError: $error");
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                              }),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.paypal),
                        Text(
                          "Paypal",
                          style: GoogleFonts.kalam(
                            fontSize: 22,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

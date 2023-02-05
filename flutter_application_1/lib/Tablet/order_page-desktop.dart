import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Services/order_service.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class OrderPage extends StatefulWidget {
  List<Print> printing;
  OrderPage({Key? key, required this.printing}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _isObscure = true;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  TextEditingController _billing_adress_controller = TextEditingController();
  TextEditingController _delivery_adress_controller = TextEditingController();

  Future? _futureOrder;
  late Future<int> order;
  double? finalPrice;

  late String userId;
  // late User user;

  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    userId = (await UserService().storage.read(key: 'userID'))!;
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
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Center(
                child: Container(
                  margin: EdgeInsets.only(right: 50),
                  child: DefaultTextStyle(
                      style: GoogleFonts.kalam(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      // ignore: prefer_const_constructors
                      child: Text('Récapitulatif')),
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                matchTextDirection: true,
                repeat: ImageRepeat.noRepeat,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
            child: Container(
              height: height,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        height: height * 0.7,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          margin: EdgeInsets.only(top: height * 0.05),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: ListView.builder(
                            itemCount: widget.printing.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      //                   <--- left side
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.01),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: height * 0.1,
                                        width: width * 0.08,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            alignment: Alignment.center,
                                            matchTextDirection: true,
                                            repeat: ImageRepeat.noRepeat,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(widget
                                                .printing[index]
                                                .imagePrintings[0]
                                                .image),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              widget.printing[index].title,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: const Text(
                                                  'Couleur :',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  widget.printing[index]
                                                      .default_material!.color,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Container(
                                          child: Text(
                                            widget.printing[index].price
                                                    .toString() +
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
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
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
                                    builder: (BuildContext context, value,
                                        Widget? child) {
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
                                            'Prix total : ' +
                                                val.toString() +
                                                ' €',
                                            style: GoogleFonts.robotoCondensed(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
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
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: height * 0.15),
                        width: width * 0.4,
                        child: Text(
                          "Le choix d'un transporteur étant actuellement indisponible, le prix total contient les frais d'expédition",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kalam(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 155, 43, 35),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40),
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
                              margin: const EdgeInsets.only(top: 40),
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
                        margin: EdgeInsets.symmetric(vertical: height * 0.05),
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

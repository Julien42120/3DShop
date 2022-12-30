import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Services/order_service.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/User/log-in-page-desktop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  double finalPrice;
  OrderPage({Key? key, required this.finalPrice}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _isObscure = true;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  TextEditingController _billing_adress_controller = TextEditingController();
  TextEditingController _delivery_adress_controller = TextEditingController();

  Future? _futureOrder;
  late List printing;
  double? finalPrice;

  late String userId;

  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    userId = (await UserService().storage.read(key: 'userID'))!;
    // finalPrice = ValueNotifier<double>().value;
    print(finalPrice);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.red,
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
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    // ignore: prefer_const_constructors
                    child: Text('Commande')),
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(
            top: height * 0.15,
          ),
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: FutureBuilder(
            future: _futureOrder,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Container(
                margin: EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Consumer<ProductsVM>(
                      builder: (BuildContext context, value, Widget? child) {
                        ValueNotifier<double> totalPrice = ValueNotifier(0);
                        for (var element in value.lst) {
                          totalPrice.value = totalPrice.value + element.price;
                        }
                        return ValueListenableBuilder<double?>(
                            valueListenable: totalPrice,
                            builder: (context, val, child) {
                              return Text(
                                'prix total : ' + val.toString() + ' €',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              );
                            });
                      },
                    ),
                    Center(
                      child: Container(
                        width: 400,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextField(
                                controller: _billing_adress_controller,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Adresse de Facturation",
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
                                  labelText: "Adresse de Livraison",
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPageDesktop()),
                          );
                          setState(() {
                            _futureOrder = OrderService().createOrder(
                                userId,
                                _billing_adress_controller.text,
                                _delivery_adress_controller.text,
                                [],
                                widget.finalPrice);
                          });
                        },
                        child: Text(
                          "Choix du transporteur",
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}

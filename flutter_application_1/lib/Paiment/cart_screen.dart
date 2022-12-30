import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Order/order_page.dart';
import 'package:flutter_application_1/Paiment/cart_item.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/User/log-in-page-desktop.dart';
import 'package:flutter_application_1/navBar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // late List<Print> listProducts;
  double _totalPrice = 0.0;

  String? userConnected;

  @override
  initState() {
    setState(() {});
    _getData();
  }

  void _getData() async {
    userConnected = await UserService().storage.read(key: 'token');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBarDesktop(),
      ),
      body: Consumer<ProductsVM>(
        builder: (context, value, child) => SafeArea(
          child: Column(
            children: [
              Container(
                height: height * 0.15,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Mon panier',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: height * 0.65,
                child: ListView.builder(
                  itemCount: value.lst.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(120, 142, 142, 142),
                                  offset: Offset(0, 7),
                                  blurRadius: 8,
                                  spreadRadius: 3)
                            ]),
                        child: Icon(Icons.delete),
                      ),
                      onDismissed: (direction) {
                        value.delete(index);
                      },
                      child: CartItem(
                        image: value.lst[index].imagePrintings[0].image,
                        itemName: value.lst[index].title,
                        price: value.lst[index].price.toString(),
                        description: value.lst[index].description,
                        weight: value.lst[index].default_weight.toString(),
                        material: value.lst[index].default_material!.color,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    height: height * 0.25,
                    color: const Color.fromARGB(83, 70, 173, 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<ProductsVM>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            ValueNotifier<double> totalPrice = ValueNotifier(0);
                            for (var element in value.lst) {
                              totalPrice.value =
                                  totalPrice.value + element.price;
                            }
                            return ValueListenableBuilder<double?>(
                                valueListenable: totalPrice,
                                builder: (context, val, child) {
                                  return Text(
                                    'prix total : ' + val.toString() + ' €',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  );
                                });
                          },
                        ),
                        // userConnected != null
                        //     ?
                        InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          splashColor: Colors.red.withOpacity(0.8),
                          focusColor: Colors.white,
                          hoverColor: const Color.fromARGB(124, 70, 173, 19),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderPage(
                                  finalPrice: 100,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.price_check_rounded,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Text(
                                    "Commander",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        // : InkWell(
                        //     borderRadius: const BorderRadius.all(
                        //       Radius.circular(10),
                        //     ),
                        //     splashColor: Colors.red.withOpacity(0.8),
                        //     focusColor: Colors.white,
                        //     hoverColor:
                        //         const Color.fromARGB(124, 70, 173, 19),
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   LogInPageDesktop()));
                        //     },
                        //     child: Container(
                        //       padding: const EdgeInsets.all(10),
                        //       child: Row(
                        //         children: [
                        //           const Icon(
                        //             Icons.price_check_rounded,
                        //             color: Colors.white,
                        //           ),
                        //           Container(
                        //             margin: const EdgeInsets.symmetric(
                        //                 horizontal: 10),
                        //             child: const Text(
                        //               "Commander",
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Tablet/order_page-desktop.dart';
import 'package:flutter_application_1/Paiment/cart_item-desktop.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/Tablet/register-page-desktop.dart';
import 'package:flutter_application_1/navBar-desktop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreenDesktop extends StatefulWidget {
  @override
  _CartScreenDesktopState createState() => _CartScreenDesktopState();
}

class _CartScreenDesktopState extends State<CartScreenDesktop> {
  List<Print> listProducts = [];

  String? userConnected;

  @override
  initState() {
    setState(() {});
    _getData();
  }

  getCartItem(prints) {
    for (var i = 0; i < prints.length; i++) {
      listProducts = prints;
    }
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
                child: Text(
                  'Mon panier',
                  style: GoogleFonts.kalam(
                      fontSize: 45,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: height * 0.65,
                width: width * 0.95,
                child: ListView.builder(
                  itemCount: value.lst.length,
                  itemBuilder: (context, index) {
                    getCartItem(value.lst);
                    return Center(
                      child: Dismissible(
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
                        child: CartItemDesktop(
                          image: value.lst[index].imagePrintings[0].image,
                          itemName: value.lst[index].title,
                          price: value.lst[index].price.toString(),
                          description: value.lst[index].description,
                          weight: value.lst[index].default_weight.toString(),
                          material: value.lst[index].default_material!.color,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
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
                            userConnected == null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPageDesktop(),
                                    ),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderPage(printing: listProducts),
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

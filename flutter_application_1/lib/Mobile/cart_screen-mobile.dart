import 'package:flutter/material.dart';
import 'package:flutter_application_1/Mobile/order-page-mobile.dart';
import 'package:flutter_application_1/Mobile/register-page-mobile.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Paiment/cart_item-mobile.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreenMobile extends StatefulWidget {
  @override
  _CartScreenMobileState createState() => _CartScreenMobileState();
}

class _CartScreenMobileState extends State<CartScreenMobile> {
  List<Print> listProductsMobile = [];

  String? userConnected;

  @override
  initState() {
    setState(() {});
    _getData();
  }

  getCartItem(prints) {
    for (var i = 0; i < prints.length; i++) {
      listProductsMobile = prints;
    }
  }

  void _getData() async {
    userConnected = await UserService().storage.read(key: 'userConnected');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: CustomAppBarMobile(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            matchTextDirection: true,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background.jpg'),
          ),
        ),
        child: Consumer<ProductsVM>(
          builder: (context, value, child) => SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: height * 0.08,
                  ),
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    'Panier',
                    style: GoogleFonts.kalam(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.62,
                  margin: EdgeInsets.only(
                    top: height * 0.08,
                  ),
                  child: ListView.builder(
                    itemCount: value.lst.length,
                    itemBuilder: (context, index) {
                      getCartItem(value.lst);
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(30),
                                  child: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          value.delete(index);
                        },
                        child: CartItemMobile(
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Total : ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            val.toString() + ' €',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                            InkWell(
                              onTap: () async {
                                userConnected == null
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPageMobile(),
                                        ),
                                      )
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OrderPageMobile(
                                              printing: listProductsMobile),
                                        ),
                                      );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: height * 0.005),
                                width: width * 0.5,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.price_check_rounded,
                                      color: Colors.green,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: const Text(
                                        "Commander",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

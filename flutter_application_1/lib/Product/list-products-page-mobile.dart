// pAGE
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Category/list-categories-page-mobile.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Product/config-product-page.dart';
import 'package:flutter_application_1/Services/print_service.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Paiment/cart-page.dart';

// ignore: must_be_immutable
class ProductsPageMobile extends StatefulWidget {
  late String? categoryID;
  ProductsPageMobile({Key? key, required this.categoryID}) : super(key: key);
  ProductsPageMobile.empty({Key? key}) : super(key: key);

  @override
  _ProductsPageMobileState createState() => _ProductsPageMobileState();
}

class _ProductsPageMobileState extends State<ProductsPageMobile> {
  late List<Print>? _printModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _printModel =
        await PrintService().getPrintByCategory(widget.categoryID as String);
    setState(() {});
  }

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
                  MaterialPageRoute(builder: (context) => CategoryPageMobile()),
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
        ],
      ),
      body: _printModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  matchTextDirection: true,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/marble.jpg'),
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 5),
                itemCount: _printModel?.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ConfigProductPage(
                            printId: _printModel![index].id.toString(),
                          );
                        }),
                      );
                    },
                    child: Container(
                      constraints: const BoxConstraints(
                          minHeight: 150,
                          minWidth: double.infinity,
                          maxHeight: 150),
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.center,
                            matchTextDirection: true,
                            repeat: ImageRepeat.noRepeat,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/image4.jpg'),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      _printModel![index].title,
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Paiment/cart_item.dart';
import 'package:flutter_application_1/navBar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

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
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Mon panier',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: height *
                      0.785, //height to 10% of screen height, 100/10 = 0.1
                  width: width, //width t 70% of screen width
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

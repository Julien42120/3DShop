import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/material.dart';

class CartItemMobile extends StatelessWidget {
  const CartItemMobile({
    Key? key,
    required this.image,
    required this.itemName,
    required this.price,
    required this.description,
    required this.weight,
    required this.material,
  }) : super(key: key);

  final String image, itemName, price, description, weight, material;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(120, 142, 142, 142),
                offset: Offset(0, 7),
                blurRadius: 8,
                spreadRadius: 3)
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: height * 0.12,
                width: width * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    matchTextDirection: true,
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
              ),
              Container(
                width: width * 0.650, //width t 70% of screen width
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        itemName,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        description,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: const Text(
                                'Couleur :',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                material,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  'Prix : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ),
                              Container(
                                child: Text(
                                  price + ' €',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

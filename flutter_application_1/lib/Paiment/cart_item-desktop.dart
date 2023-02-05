import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemDesktop extends StatelessWidget {
  const CartItemDesktop({
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
      child: Container(
        width: width * 0.7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              height: 100,
              width: width * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  matchTextDirection: true,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(8, 8),
                    spreadRadius: -6,
                    blurRadius: 15,
                    color: Color.fromARGB(255, 75, 75, 75),
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    itemName,
                    style: GoogleFonts.kalam(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      description,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Couleur :',
                    style: GoogleFonts.kalam(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    material,
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Poids :',
                    style: GoogleFonts.kalam(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    weight + ' grammes',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Prix :',
                    style: GoogleFonts.kalam(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    price + ' €',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Container(
                //   height: 20,
                //   width: 250,
                //   child: const Text(
                //     'Swipe sur la gauche pour supprimer',
                //     style: TextStyle(fontSize: 10, color: Colors.red),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

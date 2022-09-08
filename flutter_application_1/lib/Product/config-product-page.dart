import 'package:flutter/material.dart';
import 'package:flutter_application_1/Category/list-categories-page-mobile.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Services/print_service.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_application_1/Paiment/cart-page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ConfigProductPage extends StatefulWidget {
  String? printId;
  ConfigProductPage({Key? key, required this.printId}) : super(key: key);

  @override
  State<ConfigProductPage> createState() => _ConfigProductPageState();
}

class _ConfigProductPageState extends State<ConfigProductPage> {
  Print? printing;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    var printing = await PrintService().getPrintById(widget.printId as String);
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
      // ignore: unnecessary_null_comparison
      body: printing == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 900,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    matchTextDirection: true,
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/marble.jpg'),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.noRepeat,
                            image: AssetImage('assets/images/image4.jpg')),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          printing!.title,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(30),
                      child: Text(
                        printing!.description,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 40),
                            child: Text(
                              printing!.price.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: DropdownButton(
                              items: dropdownResist,
                              onChanged: (String? value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            child: const Text(
                              'Sélectionnez une couleur',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: DropdownButton(
                              items: dropdownColors,
                              onChanged: (String? value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 60),
                            child: const Text(
                              'Sélectionnez un format',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: DropdownButton(
                              items: dropdownItems,
                              onChanged: (String? value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          color: const Color.fromARGB(122, 184, 184, 184),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    printing!.price.toString() + '€',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 156, 44),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CartPage()),
                                  );
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.shopping_cart_checkout,
                                      color: Color.fromARGB(255, 0, 156, 44),
                                      size: 35,
                                    ),
                                    Text(
                                      'Acheter',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("20 cm"), value: "20"),
    const DropdownMenuItem(child: Text("25 cm"), value: "25"),
    const DropdownMenuItem(child: Text("30 cm"), value: "30"),
    const DropdownMenuItem(child: Text("35 cm"), value: "35"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownResist {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("PLA"), value: "PLA"),
    const DropdownMenuItem(child: Text("ABS"), value: "ABS"),
    const DropdownMenuItem(child: Text("PETG"), value: "PETG"),
    const DropdownMenuItem(child: Text("TPU"), value: "TPU"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownColors {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Rouge"), value: "Rouge"),
    const DropdownMenuItem(child: Text("Bleu"), value: "Bleu"),
    const DropdownMenuItem(child: Text("Noir"), value: "Noir"),
    const DropdownMenuItem(child: Text("Blanc"), value: "Blanc"),
    const DropdownMenuItem(child: Text("Vert"), value: "Vert"),
    const DropdownMenuItem(child: Text("Jaune"), value: "Jaune"),
  ];
  return menuItems;
}

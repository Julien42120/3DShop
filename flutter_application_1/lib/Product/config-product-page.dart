import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/imagePrint.dart';
import 'package:flutter_application_1/Models/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Services/cart_print_service.dart';
import 'package:flutter_application_1/Services/material_service.dart';
import 'package:flutter_application_1/Services/print_service.dart';
import 'package:flutter_application_1/User/register-page-desktop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ConfigProductPage extends StatefulWidget {
  String printId;
  ConfigProductPage({Key? key, required this.printId}) : super(key: key);

  @override
  State<ConfigProductPage> createState() => _ConfigProductPageState();
}

class _ConfigProductPageState extends State<ConfigProductPage> {
  late List<MaterialPrint>? listmaterial = [];
  Print? printing;
  late List<ImagePrint>? imagesPrint = [];
  late Print printId;

  PrintService printService = PrintService();
  MaterialService materialService = MaterialService();
  CartService cartService = CartService();
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  MaterialPrint? selectedValue;
  List<MaterialPrint> itemsValues = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    printing = await printService.getPrintById(widget.printId);
    listmaterial = await materialService.getMaterialList();
    imagesPrint = await printService.getImagesPrint(widget.printId);
    selectedValue = listmaterial!.first;
    for (var i = 0; i < listmaterial!.length; i++) {
      itemsValues.add(listmaterial![i]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Center(
                child: DefaultTextStyle(
              style: GoogleFonts.robotoCondensed(
                fontSize: 30,
                color: Colors.black,
              ),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    'Configuration ',
                    speed: Duration(milliseconds: 230),
                  ),
                ],
              ),
            )),
            actions: [
              OpenContainer<bool>(
                closedColor: Colors.transparent,
                openColor: Colors.transparent,
                transitionType: _transitionType,
                transitionDuration: Duration(milliseconds: 1400),
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return RegisterPageDesktop();
                },
                closedElevation: 0.0,
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: const Icon(
                      Icons.person_add,
                      size: 40,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
            backgroundColor: Colors.white,
          ),
        ),
      ),
      // ignore: unnecessary_null_comparison
      body: printing == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  matchTextDirection: true,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/background.jpg'),
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 450.0),
                    items: imagesPrint!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Image.network(
                              i.image,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                printing!.title,
                                style: GoogleFonts.robotoCondensed(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Text(
                                      'Proposé par: ',
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    printing!.user.pseudo,
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    matchTextDirection: true,
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(printing!.user.avatar),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Text(
                          printing!.description,
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Taille: ',
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    printing!.default_size.toString() + ' cm',
                                    style: GoogleFonts.robotoCondensed(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Poids: ',
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    printing!.default_weight.toString() +
                                        ' grammes',
                                    style: GoogleFonts.robotoCondensed(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 30),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.warning),
                                    Text(
                                      'Tout changement de couleur aura des coups supplémentaires',
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )
                                  ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Choisir une couleur : ',
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                DropdownButton(
                                  value: selectedValue,
                                  items: itemsValues.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.color),
                                      value: item,
                                    );
                                  }).toList(),
                                  onChanged: (value) async {
                                    setState(() {
                                      selectedValue = value as MaterialPrint?;
                                    });
                                    await cartService.postConfig(
                                        printing, selectedValue);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Prix de base : ',
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  printing!.price.toString() + '€',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      // CartService()
                                      //     .postConfig(printing, listmaterial);
                                    },
                                    icon: Icon(Icons.shopping_bag),
                                    label: Text('panier'))
                              ],
                            ),
                          )
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            ),
    );
  }
}

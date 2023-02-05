import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/imagePrint.dart';
import 'package:flutter_application_1/Models/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Services/cart_service.dart';
import 'package:flutter_application_1/Services/config_service.dart';
import 'package:flutter_application_1/Services/material_service.dart';
import 'package:flutter_application_1/Services/print_service.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ConfigProductPageMobile extends StatefulWidget {
  String printId;
  String nameOfCategorie;
  ConfigProductPageMobile(
      {Key? key, required this.printId, required this.nameOfCategorie})
      : super(key: key);

  @override
  State<ConfigProductPageMobile> createState() =>
      _ConfigProductPageMobileState();
}

class _ConfigProductPageMobileState extends State<ConfigProductPageMobile> {
  Future<double>? _price;

  late String selectedValueId;
  late String actualPrintId;

  late List<MaterialPrint>? listmaterial = [];
  Print? printing;
  late List<ImagePrint>? imagesPrint = [];

  String? userConnectedId;

  PrintService printService = PrintService();
  MaterialService materialService = MaterialService();
  ConfigService configService = ConfigService();
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
    actualPrintId = widget.printId.toString();
    printing = await printService.getPrintById(widget.printId);
    imagesPrint = await printService.getImagesPrint(widget.printId);
    listmaterial = await materialService.getMaterialList();

    selectedValue = listmaterial!.first;

    for (var i = 0; i < listmaterial!.length; i++) {
      itemsValues.add(listmaterial![i]);
    }
    _price = Future<double>.delayed(
        const Duration(seconds: 2), (() => printing!.price));

    userConnectedId = await storage.read(key: 'userID');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: CustomAppBarMobile(),
      // ignore: unnecessary_null_comparison
      body: printing == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        matchTextDirection: true,
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/background.jpg'),
                      ),
                    ),
                    child: Column(
                      children: [
                        Positioned(
                          top: -10,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: height * 0.50,
                              autoPlay: true,
                            ),
                            items: imagesPrint!.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    child: Image.network(
                                      i.image,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: width,
                          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              alignment: Alignment.center,
                              matchTextDirection: true,
                              repeat: ImageRepeat.noRepeat,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/background.jpg'),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, -1),
                                spreadRadius: 0,
                                blurRadius: 10,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.8,
                                margin: EdgeInsets.only(top: height * 0.02),
                                child: Center(
                                  child: Text(
                                    printing!.title,
                                    style: GoogleFonts.kalam(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width,
                                margin: EdgeInsets.only(top: height * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 2),
                                              child: Text(
                                                'Proposé par: ',
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              alignment: Alignment.center,
                                              matchTextDirection: true,
                                              repeat: ImageRepeat.noRepeat,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  printing!.user.avatar),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100)),
                                          ),
                                        ),
                                        Text(
                                          printing!.user.pseudo,
                                          style: GoogleFonts.robotoCondensed(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'Taille: ',
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  printing!.default_size
                                                          .toString() +
                                                      ' cm',
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'Poids: ',
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  printing!.default_weight
                                                          .toString() +
                                                      ' grammes',
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'Catégorie: ',
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  widget.nameOfCategorie,
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width * 0.9,
                                margin: EdgeInsets.symmetric(vertical: 35),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Description :',
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.65,
                                      child: Text(
                                        printing!.description,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              printing!.default_material == null
                                  ? SizedBox(
                                      height: height * 0.2,
                                      width: width * 0.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: height * 0.03),
                                            child: Text(
                                              'Aucune configuration disponible sur ce produit',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.kalam(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        printing!.default_material != null
                            ? Container(
                                width: width,
                                transform:
                                    Matrix4.translationValues(0.0, -40.0, 0.0),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    matchTextDirection: true,
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/background.jpg'),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, -1),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: width,
                                      margin:
                                          EdgeInsets.only(top: height * 0.02),
                                      child: Center(
                                        child: Text(
                                          'Configuration',
                                          style: GoogleFonts.kalam(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 30),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Choisir une couleur : ',
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              DropdownButton(
                                                alignment: Alignment.center,
                                                iconSize: 20,
                                                value: selectedValue,
                                                items: itemsValues.map((item) {
                                                  return DropdownMenuItem(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 20),
                                                          child: Text(
                                                            '(' +
                                                                item.type_name +
                                                                ')',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ),
                                                        Text(item.color),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          height: 25,
                                                          width: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              matchTextDirection:
                                                                  true,
                                                              repeat:
                                                                  ImageRepeat
                                                                      .noRepeat,
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  item.image),
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    value: item,
                                                  );
                                                }).toList(),
                                                onChanged: (value) async {
                                                  setState(() {
                                                    selectedValue =
                                                        value as MaterialPrint;
                                                    selectedValueId =
                                                        value.id.toString();
                                                  });
                                                  await configService
                                                      .postConfig(actualPrintId,
                                                          selectedValueId);
                                                  setState(() {
                                                    _price = configService
                                                        .postConfig(
                                                            actualPrintId,
                                                            selectedValueId);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: height * 0.05),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.warning,
                                                  color: Color.fromARGB(
                                                      255, 110, 30, 25),
                                                ),
                                                Container(
                                                  width: width * 0.8,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Tout changement de couleur peut engendrer des coûts supplémentaires',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts
                                                        .robotoCondensed(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 110, 30, 25),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          width: width,
                          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              alignment: Alignment.center,
                              matchTextDirection: true,
                              repeat: ImageRepeat.noRepeat,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/background-black.jpg'),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, -1),
                                spreadRadius: 0,
                                blurRadius: 10,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: height * 0.03),
                                width: width * 0.9,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        FutureBuilder<double>(
                                          future:
                                              _price, // a previously-obtained Future<String> or null
                                          builder: (BuildContext context,
                                              AsyncSnapshot<double> snapshot) {
                                            List<Widget> children;
                                            if (snapshot.hasData) {
                                              children = <Widget>[
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5),
                                                  child: Text(
                                                      '${snapshot.data}' "€",
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      )),
                                                ),
                                              ];
                                            } else if (snapshot.hasError) {
                                              children = <Widget>[
                                                const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.red,
                                                  size: 60,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16),
                                                  child: Text(
                                                      'Error: ${snapshot.error}'),
                                                ),
                                              ];
                                            } else {
                                              children = const <Widget>[
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ];
                                            }
                                            return Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: children,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Consumer<ProductsVM>(
                                            builder: (context, value, child) =>
                                                Material(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: InkWell(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                splashColor:
                                                    Colors.red.withOpacity(0.8),
                                                focusColor: Colors.white,
                                                hoverColor: Color.fromARGB(
                                                    124, 70, 173, 19),
                                                onTap: () async {
                                                  value.add(
                                                    printing!.id,
                                                    printing!.category,
                                                    printing!.user,
                                                    printing!.title,
                                                    printing!.description,
                                                    await _price!,
                                                    printing!.default_size,
                                                    printing!.default_weight,
                                                    selectedValue!,
                                                    imagesPrint!,
                                                    printing!
                                                        .nbr_of_printing_hours,
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            const Text(
                                                              'Produit ajouté',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            IconButton(
                                                                icon: Icon(Icons
                                                                    .close),
                                                                onPressed: () {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .hideCurrentSnackBar();
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 64, 172, 68),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .add_shopping_cart_sharp,
                                                        color: Color.fromARGB(
                                                            124, 70, 173, 19),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 5),
                                                        child: const Text(
                                                          "Ajouter au panier",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    124,
                                                                    70,
                                                                    173,
                                                                    19),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

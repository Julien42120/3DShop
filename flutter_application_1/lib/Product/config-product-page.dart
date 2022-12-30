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
import 'package:flutter_application_1/navBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ConfigProductPage extends StatefulWidget {
  String printId;
  ConfigProductPage({Key? key, required this.printId}) : super(key: key);

  @override
  State<ConfigProductPage> createState() => _ConfigProductPageState();
}

class _ConfigProductPageState extends State<ConfigProductPage> {
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
    listmaterial = await materialService.getMaterialList();
    imagesPrint = await printService.getImagesPrint(widget.printId);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBarDesktop(),
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
                    padding:
                        EdgeInsets.only(left: 40, right: 40, top: height * 0.2),
                    decoration:
                        BoxDecoration(color: Color.fromARGB(83, 70, 173, 19)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      image:
                                          NetworkImage(printing!.user.avatar),
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
                          margin: EdgeInsets.only(top: 55),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 7),
                                    child: Row(
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
                                        Text(
                                          printing!.default_size.toString() +
                                              ' cm',
                                          style: GoogleFonts.robotoCondensed(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
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
                              Container(
                                width:
                                    width * 0.26, //width t 70% of screen width
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                child: Text(
                                  printing!.description,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        printing!.default_material != null
                            ? Container(
                                margin: EdgeInsets.only(top: 30, bottom: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Text(
                                                      '(' +
                                                          item.type_name +
                                                          ')',
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Text(item.color),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        alignment:
                                                            Alignment.center,
                                                        matchTextDirection:
                                                            true,
                                                        repeat: ImageRepeat
                                                            .noRepeat,
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            item.image),
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(5),
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
                                            await configService.postConfig(
                                                actualPrintId, selectedValueId);
                                            setState(() {
                                              _price = configService.postConfig(
                                                  actualPrintId,
                                                  selectedValueId);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          margin: const EdgeInsets.only(top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Prix : ',
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<double>(
                                    future:
                                        _price, // a previously-obtained Future<String> or null
                                    builder: (BuildContext context,
                                        AsyncSnapshot<double> snapshot) {
                                      List<Widget> children;
                                      if (snapshot.hasData) {
                                        children = <Widget>[
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            child: Text('${snapshot.data}' "€",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
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
                                                const EdgeInsets.only(top: 16),
                                            child: Text(
                                                'Error: ${snapshot.error}'),
                                          ),
                                        ];
                                      } else {
                                        children = const <Widget>[
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<ProductsVM>(
                                    builder: (context, value, child) =>
                                        Material(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        splashColor:
                                            Colors.red.withOpacity(0.8),
                                        focusColor: Colors.white,
                                        hoverColor:
                                            Color.fromARGB(124, 70, 173, 19),
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
                                            printing!.nbr_of_printing_hours,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Produit ajouté',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 64, 172, 68),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.add_shopping_cart_sharp,
                                                color: Color.fromARGB(
                                                    124, 70, 173, 19),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: const Text(
                                                  "Ajouter au panier",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        124, 70, 173, 19),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                  )
                ],
              ),
            ),
    );
  }
}

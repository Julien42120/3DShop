// pAGE
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Mobile/config-product-page-mobile.dart';
import 'package:flutter_application_1/Models/imagePrint.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Services/print_service.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProductsPageMobile extends StatefulWidget {
  String nameOfCategory;
  late String? categoryID;

  ProductsPageMobile(
      {Key? key, required this.categoryID, required this.nameOfCategory})
      : super(key: key);

  @override
  _ProductsPageMobileState createState() => _ProductsPageMobileState();
}

class _ProductsPageMobileState extends State<ProductsPageMobile> {
  late List<Print>? _printModel = [];
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  late List<ImagePrint>? imagesPrint = [];

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: CustomAppBarMobile(),
      body: _printModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                  Container(
                    margin: EdgeInsets.only(top: height * 0.05),
                    child: Center(
                        child: Text(
                      widget.nameOfCategory,
                      style: GoogleFonts.kalam(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 0.5,
                      ),
                      itemCount: _printModel!.length,
                      itemBuilder: (BuildContext ctx, index) =>
                          OpenContainer<bool>(
                        closedColor: Colors.transparent,
                        openColor: Colors.transparent,
                        transitionType: _transitionType,
                        transitionDuration: const Duration(milliseconds: 600),
                        openBuilder: (BuildContext _, openContainer) {
                          return ConfigProductPageMobile(
                            printId: _printModel![index].id.toString(),
                            nameOfCategorie: widget.nameOfCategory,
                          );
                        },
                        closedElevation: 0.0,
                        closedBuilder:
                            (BuildContext _, VoidCallback openContainer) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 600),
                            columnCount: 1,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: Container(
                                  margin: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      alignment: Alignment.center,
                                      matchTextDirection: true,
                                      repeat: ImageRepeat.noRepeat,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(_printModel![index]
                                          .imagePrintings[0]
                                          .image),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(8, 8),
                                        spreadRadius: -6,
                                        blurRadius: 15,
                                        color: Color.fromARGB(255, 75, 75, 75),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 5),
                                            decoration: const BoxDecoration(
                                              color:
                                                  Color.fromARGB(70, 0, 0, 0),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            margin: const EdgeInsets.all(10),
                                            child: Text(
                                              _printModel![index].title,
                                              style: GoogleFonts.kalam(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

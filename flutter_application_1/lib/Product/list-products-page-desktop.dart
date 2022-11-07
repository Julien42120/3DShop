import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Product/config-product-page.dart';
import 'package:flutter_application_1/Services/print_service.dart';
import 'package:flutter_application_1/User/register-page-desktop.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProductsPageDesktop extends StatefulWidget {
  String nameOfCategory;
  late String categoryID;

  ProductsPageDesktop(
      {Key? key, required this.categoryID, required this.nameOfCategory})
      : super(key: key);

  @override
  _ProductsPageDesktopState createState() => _ProductsPageDesktopState();
}

class _ProductsPageDesktopState extends State<ProductsPageDesktop> {
  late List<Print> _printModel = [];
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _printModel = await PrintService().getPrintByCategory(widget.categoryID);

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
                    widget.nameOfCategory,
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
                transitionDuration: Duration(milliseconds: 600),
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
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ],
            backgroundColor: Colors.white,
          ),
        ),
      ),
      body: _printModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  matchTextDirection: true,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/background.jpg'),
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 800,
                    childAspectRatio: 2 / 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemCount: _printModel.length,
                itemBuilder: (BuildContext ctx, index) => OpenContainer<bool>(
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  transitionType: _transitionType,
                  transitionDuration: const Duration(milliseconds: 600),
                  openBuilder: (BuildContext _, openContainer) {
                    return ConfigProductPage(
                      printId: _printModel[index].id.toString(),
                    );
                  },
                  closedElevation: 0.0,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      columnCount: 1,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Container(
                            margin: const EdgeInsets.all(25),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment.center,
                                matchTextDirection: true,
                                repeat: ImageRepeat.noRepeat,
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/image4.jpg'),
                              ),
                              boxShadow: [
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            _printModel[index].title,
                                            style: GoogleFonts.robotoCondensed(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'A partir de ' +
                                                _printModel[index]
                                                    .price
                                                    .toString() +
                                                '€',
                                            style: GoogleFonts.robotoCondensed(
                                              fontSize: 16,
                                              color: Colors.white,
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
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

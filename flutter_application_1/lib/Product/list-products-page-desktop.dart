// pAGE
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Product/config-product-page.dart';
import 'package:flutter_application_1/Services/print_service.dart';
import 'package:flutter_application_1/User/register-page-desktop.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProductsPageDesktop extends StatefulWidget {
  late String? categoryID;
  ProductsPageDesktop({Key? key, required this.categoryID}) : super(key: key);
  ProductsPageDesktop.empty({Key? key}) : super(key: key);

  @override
  _ProductsPageDesktopState createState() => _ProductsPageDesktopState();
}

class _ProductsPageDesktopState extends State<ProductsPageDesktop> {
  late List<Print>? _printModel = [];
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 31, 31, 31)),
          child: AppBar(
            title: Center(
              child: Text(
                'Catégories',
                style: GoogleFonts.lobster(
                  fontSize: 35,
                ),
              ),
            ),
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
                        ));
                  }),
            ],
            backgroundColor: Colors.transparent,
          ),
        ),
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
                  image: AssetImage('assets/images/galaxy.png'),
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
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
                                      style: GoogleFonts.lobster(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'A partir de ' +
                                          _printModel![index].price.toString() +
                                          '€',
                                      style: GoogleFonts.lobster(
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
                  );
                },
              ),
            ),
    );
  }
}

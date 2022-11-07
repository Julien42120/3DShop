import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/category.dart';
import 'package:flutter_application_1/Product/list-products-page-desktop.dart';
import 'package:flutter_application_1/Product/list-products-page-mobile.dart';
import 'package:flutter_application_1/Services/category_service.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_application_1/User/register-page-desktop.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Paiment/cart-page.dart';

// ignore: use_key_in_widget_constructors
class CategoryPageMobile extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryPageMobile> {
  late List<Category>? _categoryModel = [];
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    // ignore prefer_conditional_assignment
    _categoryModel = await CategoryService().getCategoriesList();
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
        backgroundColor: Colors.black,
        children: [
          SpeedDialChild(
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              }),
          SpeedDialChild(
              child: const Icon(
                Icons.person_add,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPageDesktop()),
                );
              }),
        ],
      ),
      body: _categoryModel == null
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
                    maxCrossAxisExtent: 400,
                    childAspectRatio: 2 / 1,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3),
                itemCount: _categoryModel?.length,
                itemBuilder: (BuildContext ctx, index) => OpenContainer<bool>(
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  transitionType: _transitionType,
                  transitionDuration: const Duration(
                    milliseconds: 600,
                  ),
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return ProductsPageMobile(
                      categoryID: _categoryModel![index].id.toString(),
                    );
                  },
                  closedElevation: 0.0,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return Container(
                      constraints: const BoxConstraints(
                          minHeight: 150,
                          minWidth: double.infinity,
                          maxHeight: 150),
                      margin: const EdgeInsets.all(8),
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
                            offset: Offset(13, 13),
                            spreadRadius: -6,
                            blurRadius: 15,
                            color: Color.fromRGBO(0, 0, 0, 1),
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
                                child: Text(
                                  _categoryModel![index].category,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

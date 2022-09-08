import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/category.dart';
import 'package:flutter_application_1/Product/list-products-page-desktop.dart';
import 'package:flutter_application_1/Services/category_service.dart';
import 'package:flutter_application_1/User/register-page-desktop.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: use_key_in_widget_constructors
class CategoryPageDesktop extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryPageDesktop> {
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
                  image: AssetImage('assets/images/galaxy.png'),
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 800,
                    childAspectRatio: 3 / 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemCount: _categoryModel?.length,
                itemBuilder: (BuildContext ctx, index) => OpenContainer<bool>(
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  transitionType: _transitionType,
                  transitionDuration: Duration(milliseconds: 1400),
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return ProductsPageDesktop(
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(_categoryModel![index].category,
                                    style: GoogleFonts.lobster(
                                      fontSize: 30,
                                      color: Colors.white,
                                    )),
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

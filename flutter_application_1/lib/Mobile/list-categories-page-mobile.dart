import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/category.dart';
import 'package:flutter_application_1/Mobile/list-products-page-mobile.dart';
import 'package:flutter_application_1/Services/category_service.dart';
import 'package:flutter_application_1/navBar-mobile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: CustomAppBarMobile(),
      body: _categoryModel == null
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 0.5,
                ),
                itemCount: _categoryModel?.length,
                itemBuilder: (BuildContext ctx, index) => OpenContainer<bool>(
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  transitionType: _transitionType,
                  transitionDuration: const Duration(milliseconds: 600),
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return ProductsPageMobile(
                        categoryID: _categoryModel![index].id.toString(),
                        nameOfCategory: _categoryModel![index].category);
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
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment.center,
                                matchTextDirection: true,
                                repeat: ImageRepeat.noRepeat,
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(_categoryModel![index].image),
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 5),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(70, 0, 0, 0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      child: Text(
                                        _categoryModel![index].category,
                                        style: GoogleFonts.kalam(
                                          fontSize: 20,
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
    );
  }
}

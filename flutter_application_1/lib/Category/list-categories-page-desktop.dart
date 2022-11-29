import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/category.dart';
import 'package:flutter_application_1/Product/list-products-page-desktop.dart';
import 'package:flutter_application_1/Services/category_service.dart';
import 'package:flutter_application_1/navBar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
        preferredSize: Size.fromHeight(60),
        child: CustomAppBarDesktop(),
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
                    maxCrossAxisExtent: 800,
                    childAspectRatio: 2 / 1,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1),
                itemCount: _categoryModel?.length,
                itemBuilder: (BuildContext ctx, index) => OpenContainer<bool>(
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  transitionType: _transitionType,
                  transitionDuration: const Duration(milliseconds: 600),
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return ProductsPageDesktop(
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
                            margin: const EdgeInsets.all(25),
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

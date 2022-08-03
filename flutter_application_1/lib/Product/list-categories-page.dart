import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/api_response.dart';
import 'package:flutter_application_1/Models/category.dart';
import 'package:flutter_application_1/Services/category_service.dart';
import 'package:flutter_application_1/User/account-page.dart';
import 'package:flutter_application_1/User/register-page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import '../Paiment/cart-page.dart';

// ignore: use_key_in_widget_constructors
class CategoryPage extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryPage> {
  CategorysService get service => GetIt.I<CategorysService>();

  APIResponse<List<Categorys>>? _apiResponse;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  _fetchCategories() async {
    setState(() {});
    _apiResponse = await service.getCategoriesList();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0.5,
        overlayColor: Colors.black,
        spacing: 15,
        spaceBetweenChildren: 10,
        children: [
          SpeedDialChild(
              child: Icon(Icons.home),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.shopping_cart),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.person),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountPage()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.person_add),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              }),
        ],
      ),
      body: Builder(builder: (_) {
        return ListView.separated(
          itemBuilder: (_, index) {
            return Dismissible(
              key: ValueKey(_apiResponse?.data[index].id),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              child: Text(_apiResponse!.data[index].category),
            );
          },
          itemCount: _apiResponse?.data.length ?? 0,
          separatorBuilder: (_, __) =>
              const Divider(height: 1, color: Colors.green),
        );
      }),
    );
  }
}

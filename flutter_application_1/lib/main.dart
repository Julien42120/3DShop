import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/home-page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsVM(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '3DShop',
        home: HomePage(context),
      ),
    );
  }
}

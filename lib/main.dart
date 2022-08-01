import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/category_service.dart';
import 'Product/list-categories-page.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void main() {
  getIt.registerSingleton<CategorysService>(CategorysService(),
      signalsReady: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3DShop',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          matchTextDirection: true,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/HomeScreen.jpg'),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: Container(
        margin: const EdgeInsets.only(top: 500),
        // ignore: prefer_const_constructors
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryPage()),
            );
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 0, 57, 103))),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: const Text(
              'Visiter',
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
        ),
      )),
    );
  }
}

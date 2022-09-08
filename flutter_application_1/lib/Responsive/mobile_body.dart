import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirstPage/first_screen_mobile.dart';

class MyMobileBody extends StatelessWidget {
  const MyMobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstPageMobile(),
    );
  }
}

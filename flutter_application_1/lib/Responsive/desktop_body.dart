import 'package:flutter/material.dart';
import 'package:flutter_application_1/FirstPage/first_screen_desktop.dart';

class MyDesktopBody extends StatelessWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstPageDesktop(),
    );
  }
}

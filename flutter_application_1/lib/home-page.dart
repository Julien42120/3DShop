// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop_body.dart';
import 'package:flutter_application_1/responsive/mobile_body.dart';
import 'package:flutter_application_1/responsive/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: const MyDesktopBody(),
        desktopBody: const MyMobileBody(),
      ),
    );
  }
}

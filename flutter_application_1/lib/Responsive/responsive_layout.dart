import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  // ignore: use_key_in_widget_constructors
  const ResponsiveLayout({required this.desktopBody, required this.mobileBody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > mobileWidth) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}

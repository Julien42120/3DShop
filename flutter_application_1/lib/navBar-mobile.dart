import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Mobile/account-page-mobile.dart';
import 'package:flutter_application_1/Mobile/cart_screen-mobile.dart';
import 'package:flutter_application_1/Mobile/contact-page-mobile.dart';
import 'package:flutter_application_1/Mobile/list-categories-page-mobile.dart';
import 'package:flutter_application_1/Mobile/register-page-mobile.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Paiment/cart_counter.dart';
import 'package:flutter_application_1/Tablet/cart_screen-desktop.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/Tablet/account-page-desktop.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class CustomAppBarMobile extends StatefulWidget {
  @override
  State<CustomAppBarMobile> createState() => _CustomAppBarMobileState();
}

class _CustomAppBarMobileState extends State<CustomAppBarMobile> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  String? userConnected;
  String? userNameConnected;
  String? userAvatarConnected;
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    // ignore prefer_conditional_assignment
    userConnected = await UserService().storage.read(key: 'userConnected');
    userNameConnected = await UserService().storage.read(key: 'userName');
    userAvatarConnected = await UserService().storage.read(key: 'userAvatar');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context)!.settings.name;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: width * 0.14,
          margin: EdgeInsets.only(bottom: height * 0.02),
          padding: EdgeInsets.only(left: width * 0.03),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(width)),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreenMobile()));
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 10, top: 8, bottom: 8),
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.shopping_cart_rounded,
                          color: Colors.white, size: 35)),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Consumer<ProductsVM>(
                      builder: (context, value, child) => CartCounter(
                        count: value.lst.length.toString(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          overlayOpacity: 0.5,
          overlayColor: Colors.black,
          spacing: 15,
          spaceBetweenChildren: 10,
          backgroundColor: Colors.black,
          children: [
            if (userConnected == null)
              SpeedDialChild(
                child: const Icon(
                  Icons.person_add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPageMobile()),
                  );
                },
              )
            else
              SpeedDialChild(
                child: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountPageMobile()),
                  );
                },
              ),
            if (userConnected == null)
              SpeedDialChild(
                child: const Icon(
                  Icons.mail_outline,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPageMobile()),
                  );
                },
              )
            else
              SpeedDialChild(
                child: const Icon(
                  Icons.mail_outline,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactPageMobile()),
                  );
                },
              ),
            SpeedDialChild(
              child: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPageMobile()),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}

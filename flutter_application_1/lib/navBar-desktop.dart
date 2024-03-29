import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Tablet/list-categories-page-desktop.dart';
import 'package:flutter_application_1/Tablet/contact-page-desktop.dart';
import 'package:flutter_application_1/Models/productVM.dart';
import 'package:flutter_application_1/Paiment/cart_counter.dart';
import 'package:flutter_application_1/Tablet/cart_screen-desktop.dart';
import 'package:flutter_application_1/Services/user_service.dart';
import 'package:flutter_application_1/Tablet/account-page-desktop.dart';
import 'package:flutter_application_1/Tablet/register-page-desktop.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomAppBarDesktop extends StatefulWidget {
  @override
  State<CustomAppBarDesktop> createState() => _CustomAppBarDesktopState();
}

class _CustomAppBarDesktopState extends State<CustomAppBarDesktop> {
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
    userConnected = await UserService().storage.read(key: 'token');
    userNameConnected = await UserService().storage.read(key: 'userName');
    userAvatarConnected = await UserService().storage.read(key: 'userAvatar');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Center(
              child: DefaultTextStyle(
            style: GoogleFonts.kalam(
              fontSize: 30,
              color: Colors.black,
            ),
            child: Container(),
          )),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreenDesktop()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 15, top: 8, bottom: 8),
                child: Stack(
                  children: [
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(Icons.shopping_cart_rounded,
                            color: Color.fromARGB(255, 0, 0, 0), size: 35)),
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
            if (userConnected == null)
              OpenContainer<bool>(
                closedColor: Colors.transparent,
                openColor: Colors.transparent,
                transitionType: _transitionType,
                transitionDuration: Duration(milliseconds: 600),
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return RegisterPageDesktop();
                },
                closedElevation: 0.0,
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Container(
                    margin: const EdgeInsets.only(right: 17),
                    child: const Icon(
                      Icons.mail,
                      size: 40,
                      color: Colors.black,
                    ),
                  );
                },
              )
            else
              OpenContainer<bool>(
                closedColor: Colors.transparent,
                openColor: Colors.transparent,
                transitionType: _transitionType,
                transitionDuration: Duration(milliseconds: 600),
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return ContactPageDesktop();
                },
                closedElevation: 0.0,
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Container(
                    margin: const EdgeInsets.only(right: 17),
                    child: const Icon(
                      Icons.mail,
                      size: 40,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            if (userConnected == null)
              OpenContainer<bool>(
                closedColor: Colors.transparent,
                openColor: Colors.transparent,
                transitionType: _transitionType,
                transitionDuration: Duration(milliseconds: 600),
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return RegisterPageDesktop();
                },
                closedElevation: 0.0,
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.person_add,
                      size: 45,
                      color: Colors.black,
                    ),
                  );
                },
              )
            else
              Row(
                children: [
                  OpenContainer<bool>(
                    closedColor: Colors.transparent,
                    openColor: Colors.transparent,
                    transitionType: _transitionType,
                    transitionDuration: Duration(milliseconds: 600),
                    openBuilder: (BuildContext _, VoidCallback openContainer) {
                      return AccountPage();
                    },
                    closedElevation: 0.0,
                    closedBuilder:
                        (BuildContext _, VoidCallback openContainer) {
                      return Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            if (userAvatarConnected == null)
                              Container()
                            else
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    matchTextDirection: true,
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(userAvatarConnected!),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      UserService().logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPageDesktop()),
                      );
                    },
                    child: const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ],
              ),
          ],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

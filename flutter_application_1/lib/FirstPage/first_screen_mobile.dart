import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Category/list-categories-page-mobile.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPageMobile extends StatelessWidget {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.center,
          matchTextDirection: true,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/galaxy.png'),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
          child: Column(
        children: [
          Container(
            height: 400,
            margin: EdgeInsets.only(top: 80),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                matchTextDirection: true,
                repeat: ImageRepeat.noRepeat,
                image: AssetImage('assets/images/Logo.png'),
              ),
            ),
          ),
          OpenContainer<bool>(
            transitionType: _transitionType,
            transitionDuration: Duration(milliseconds: 1400),
            openBuilder: (BuildContext _, VoidCallback openContainer) {
              return CategoryPageMobile();
            },
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
              side: BorderSide(color: Colors.white, width: 1),
            ),
            closedElevation: 0.0,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Visitez',
                      style: GoogleFonts.lobster(
                        fontSize: 35,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 15),
                      child: const Icon(Icons.arrow_forward_rounded),
                    )
                  ],
                ),
              );
            },
          )
        ],
      )),
    );
  }
}

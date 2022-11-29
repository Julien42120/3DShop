import 'package:flutter/material.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({
    Key? key,
    required this.count,
  }) : super(key: key);

  final String count;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 15,
        width: 15,
        decoration:
            const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        child: Center(
            child: Text(count,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ))));
  }
}

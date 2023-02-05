import 'dart:ffi';

import 'package:flutter_application_1/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  int id;
  User user;
  String billingAddress;
  String deliveryAddress;
  double finalPrice;

  Order({
    required this.id,
    required this.user,
    required this.billingAddress,
    required this.deliveryAddress,
    required this.finalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

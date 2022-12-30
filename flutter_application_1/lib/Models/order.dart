import 'package:flutter_application_1/Models/print.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  int id;
  User user;
  String billing_address;
  String delivery_address;
  List<Print> printing;
  double final_price;

  Order({
    required this.id,
    required this.user,
    required this.billing_address,
    required this.delivery_address,
    required this.printing,
    required this.final_price,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

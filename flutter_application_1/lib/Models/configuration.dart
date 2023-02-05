import 'package:flutter_application_1/Models/material.dart';
import 'package:flutter_application_1/Models/order.dart';
import 'package:flutter_application_1/Models/print.dart';
import 'package:json_annotation/json_annotation.dart';
part 'configuration.g.dart';

@JsonSerializable()
class Configuration {
  Order orders;
  Print printing;
  MaterialPrint material;
  double price_product;

  Configuration({
    required this.orders,
    required this.printing,
    required this.material,
    required this.price_product,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}

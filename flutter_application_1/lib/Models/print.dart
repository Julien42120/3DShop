import 'package:flutter_application_1/Models/category.dart';
import 'package:flutter_application_1/Models/imagePrint.dart';
import 'package:flutter_application_1/Models/material.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'print.g.dart';

@JsonSerializable()
class Print {
  int id;
  Category category;
  User user;
  String title;
  String description;
  double price;
  int default_size;
  int default_weight;
  MaterialPrint? default_material;
  List<ImagePrint> imagePrintings;
  int nbr_of_printing_hours;

  Print({
    required this.id,
    required this.category,
    required this.user,
    required this.title,
    required this.description,
    required this.price,
    required this.default_size,
    required this.default_weight,
    required this.default_material,
    required this.imagePrintings,
    required this.nbr_of_printing_hours,
  });

  factory Print.fromJson(Map<String, dynamic> json) => _$PrintFromJson(json);

  Map<String, dynamic> toJson() => _$PrintToJson(this);
}

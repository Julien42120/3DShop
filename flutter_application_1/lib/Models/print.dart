import 'package:flutter_application_1/Models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'print.g.dart';

@JsonSerializable()
class Print {
  int id;
  String category;
  User user;
  String title;
  String description;
  int price;
  int default_size;
  int default_weight;

  Print({
    required this.id,
    required this.category,
    required this.user,
    required this.title,
    required this.description,
    required this.price,
    required this.default_size,
    required this.default_weight,
  });

  factory Print.fromJson(Map<String, dynamic> json) => _$PrintFromJson(json);

  Map<String, dynamic> toJson() => _$PrintToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'print.g.dart';

@JsonSerializable()
class Print {
  int? id;
  String category;
  String user;
  String material;
  String title;
  String? images;
  String description;
  int price;
  int defaultSize;
  int defaultWeight;
  String? optionSize;

  Print({
    this.id,
    required this.category,
    required this.user,
    required this.material,
    required this.title,
    required this.images,
    required this.description,
    required this.price,
    // ignore: non_constant_identifier_names
    required this.defaultSize,
    // ignore: non_constant_identifier_names
    required this.defaultWeight,
    required this.optionSize,
  });

  factory Print.fromJson(Map<String, dynamic> json) => _$PrintFromJson(json);

  Map<String, dynamic> toJson() => _$PrintToJson(this);
}

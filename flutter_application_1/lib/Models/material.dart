import 'package:json_annotation/json_annotation.dart';
part 'material.g.dart';

@JsonSerializable()
class MaterialPrint {
  int id;
  String type_name;
  double lenght;
  double density;
  int price_per_kg;
  String color;

  MaterialPrint({
    required this.id,
    required this.type_name,
    required this.lenght,
    required this.density,
    required this.price_per_kg,
    required this.color,
  });

  factory MaterialPrint.fromJson(Map<String, dynamic> json) =>
      _$MaterialPrintFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialPrintToJson(this);
}

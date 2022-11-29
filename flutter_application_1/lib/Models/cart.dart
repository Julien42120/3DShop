import 'package:json_annotation/json_annotation.dart';
part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int id;
  String price;
  int quantity;
  String user;
  String printing;

  Cart({
    required this.id,
    required this.price,
    required this.quantity,
    required this.user,
    required this.printing,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  static fromMap(Map<String, Object?> result) {}
}

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String email;
  String password;
  String avatar;
  String pseudo;
  String phone;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.avatar,
    required this.pseudo,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

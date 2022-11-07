import 'package:json_annotation/json_annotation.dart';
part 'imagePrint.g.dart';

@JsonSerializable()
class ImagePrint {
  String image;

  ImagePrint({
    required this.image,
  });

  factory ImagePrint.fromJson(Map<String, dynamic> json) =>
      _$ImagePrintFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePrintToJson(this);
}

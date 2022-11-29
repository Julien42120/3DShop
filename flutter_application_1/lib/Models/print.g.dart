// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Print _$PrintFromJson(Map<String, dynamic> json) => Print(
      id: json['id'] as int,
      category: json['category'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      default_size: json['default_size'] as int,
      default_weight: json['default_weight'] as int,
      default_material: json['default_material'] == null
          ? null
          : MaterialPrint.fromJson(
              json['default_material'] as Map<String, dynamic>),
      imagePrintings: (json['imagePrintings'] as List<dynamic>)
          .map((e) => ImagePrint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrintToJson(Print instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'default_size': instance.default_size,
      'default_weight': instance.default_weight,
      'default_material': instance.default_material,
      'imagePrintings': instance.imagePrintings,
    };

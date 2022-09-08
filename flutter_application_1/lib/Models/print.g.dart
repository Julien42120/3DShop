// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Print _$PrintFromJson(Map<String, dynamic> json) => Print(
      id: json['id'] as int?,
      category: json['category'] as String,
      user: json['user'] as String,
      material: json['material'] as String,
      title: json['title'] as String,
      images: json['images'] as String?,
      description: json['description'] as String,
      price: json['price'] as int,
      defaultSize: json['defaultSize'] as int,
      defaultWeight: json['defaultWeight'] as int,
      optionSize: json['optionSize'] as String?,
    );

Map<String, dynamic> _$PrintToJson(Print instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'user': instance.user,
      'material': instance.material,
      'title': instance.title,
      'images': instance.images,
      'description': instance.description,
      'price': instance.price,
      'defaultSize': instance.defaultSize,
      'defaultWeight': instance.defaultWeight,
      'optionSize': instance.optionSize,
    };

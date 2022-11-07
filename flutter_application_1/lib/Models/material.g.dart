// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialPrint _$MaterialPrintFromJson(Map<String, dynamic> json) =>
    MaterialPrint(
      id: json['id'] as int,
      type_name: json['type_name'] as String,
      lenght: (json['lenght'] as num).toDouble(),
      density: (json['density'] as num).toDouble(),
      price_per_kg: json['price_per_kg'] as int,
      color: json['color'] as String,
    );

Map<String, dynamic> _$MaterialPrintToJson(MaterialPrint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type_name': instance.type_name,
      'lenght': instance.lenght,
      'density': instance.density,
      'price_per_kg': instance.price_per_kg,
      'color': instance.color,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Configuration _$ConfigurationFromJson(Map<String, dynamic> json) =>
    Configuration(
      orders: Order.fromJson(json['orders'] as Map<String, dynamic>),
      printing: Print.fromJson(json['printing'] as Map<String, dynamic>),
      material:
          MaterialPrint.fromJson(json['material'] as Map<String, dynamic>),
      price_product: (json['price_product'] as num).toDouble(),
    );

Map<String, dynamic> _$ConfigurationToJson(Configuration instance) =>
    <String, dynamic>{
      'orders': instance.orders,
      'printing': instance.printing,
      'material': instance.material,
      'price_product': instance.price_product,
    };

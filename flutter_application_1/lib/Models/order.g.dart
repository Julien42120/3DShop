// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      billingAddress: json['billingAddress'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      finalPrice: (json['finalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'billingAddress': instance.billingAddress,
      'deliveryAddress': instance.deliveryAddress,
      'finalPrice': instance.finalPrice,
    };

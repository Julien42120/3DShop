// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      billing_address: json['billing_address'] as String,
      delivery_address: json['delivery_address'] as String,
      printing: (json['printing'] as List<dynamic>)
          .map((e) => Print.fromJson(e as Map<String, dynamic>))
          .toList(),
      final_price: (json['final_price'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'billing_address': instance.billing_address,
      'delivery_address': instance.delivery_address,
      'printing': instance.printing,
      'final_price': instance.final_price,
    };

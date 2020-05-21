// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: json['orderId'] as String,
    customerId: json['customerId'] as String,
    vendorProduct: json['vendorProduct'] == null
        ? null
        : VendorProduct.fromJson(json['vendorProduct'] as Map<String, dynamic>),
    quantity: (json['quantity'] as num)?.toDouble(),
    location: json['location'] as String,
    orderDate: json['orderDate'] == null
        ? null
        : DateTime.parse(json['orderDate'] as String),
    statusHistory: (json['statusHistory'] as List)
        ?.map((e) => e == null
            ? null
            : OrderStatusDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'customerId': instance.customerId,
      'vendorProduct': instance.vendorProduct?.toJson(),
      'status': instance.status,
      'quantity': instance.quantity,
      'location': instance.location,
      'orderDate': instance.orderDate?.toIso8601String(),
      'statusHistory':
          instance.statusHistory?.map((e) => e?.toJson())?.toList(),
    };

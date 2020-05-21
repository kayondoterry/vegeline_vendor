// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorProduct _$VendorProductFromJson(Map<String, dynamic> json) {
  return VendorProduct(
    vendorProductId: json['vendorProductId'] as String,
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    vendor: json['vendor'] == null
        ? null
        : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
    price: (json['price'] as num)?.toDouble(),
    serviceFee: (json['serviceFee'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$VendorProductToJson(VendorProduct instance) =>
    <String, dynamic>{
      'vendorProductId': instance.vendorProductId,
      'product': instance.product?.toJson(),
      'vendor': instance.vendor?.toJson(),
      'price': instance.price,
      'serviceFee': instance.serviceFee,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    productId: json['productId'] as String,
    productName: json['productName'] as String,
    category: json['category'] as String,
    imageURL: json['imageURL'] as String,
    vendorCount: json['vendorCount'] as int,
    standardUnit: json['standardUnit'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('productId', instance.productId);
  writeNotNull('productName', instance.productName);
  writeNotNull('category', instance.category);
  writeNotNull('imageURL', instance.imageURL);
  writeNotNull('vendorCount', instance.vendorCount);
  writeNotNull('standardUnit', instance.standardUnit);
  return val;
}

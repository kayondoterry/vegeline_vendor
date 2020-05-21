import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Product {
//  static productIdToJson(pId) => null;
//
//  @JsonKey(toJson: productIdToJson)
  final String productId;
  final String productName;
  final String category;
  final String imageURL;
  final int vendorCount;
  final String standardUnit;

  Product({
    this.productId,
    this.productName,
    this.category,
    this.imageURL,
    this.vendorCount,
    this.standardUnit,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
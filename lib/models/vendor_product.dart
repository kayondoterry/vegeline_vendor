import 'package:json_annotation/json_annotation.dart';
import 'package:vegeline_vendor/models/product.dart';
import 'package:vegeline_vendor/models/vendor.dart';

part 'vendor_product.g.dart';

@JsonSerializable(explicitToJson: true)
class VendorProduct {
  final String vendorProductId;
  final Product product;
  final Vendor vendor;
  final double price;
  final double serviceFee;

  VendorProduct({this.vendorProductId, this.product, this.vendor, this.price, this.serviceFee});


  double get totalFee => price + serviceFee;

  factory VendorProduct.fromJson(Map<String, dynamic> json) =>
      _$VendorProductFromJson(json);

  Map<String, dynamic> toJson() => _$VendorProductToJson(this);
}

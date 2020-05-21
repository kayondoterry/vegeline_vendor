import 'package:json_annotation/json_annotation.dart';
import 'package:vegeline_vendor/models/vendor_product.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
//  static orderIdToJson(vId) => null;
//
//  @JsonKey(toJson: orderIdToJson)
  String orderId;
  String customerId;
  VendorProduct vendorProduct;
  String status;
  double quantity;
  String location;
  DateTime orderDate;
  List<OrderStatusDetail> statusHistory;

  Order({
    this.orderId,
    this.customerId,
    this.vendorProduct,
    this.quantity,
    this.location,
    this.orderDate,
    this.statusHistory,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  double get productFee => this.quantity * vendorProduct.price;

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

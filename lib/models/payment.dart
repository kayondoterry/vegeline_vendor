import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Payment {
  String orderId;
  double amount;


  Payment({this.orderId, this.amount});

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);


}
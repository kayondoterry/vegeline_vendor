import 'package:json_annotation/json_annotation.dart';

part 'order_status_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderStatusDetail {
  final String status;
  final String dateTime;
  final String dataField;
  final List<Map<String, dynamic>> extraFields;

  OrderStatusDetail(
      {this.status, this.dateTime, this.dataField, this.extraFields});

  factory OrderStatusDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusDetailToJson(this);

  @override
  String toString() {
    return status;;
  }
}

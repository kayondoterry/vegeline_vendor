// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusDetail _$OrderStatusDetailFromJson(Map<String, dynamic> json) {
  return OrderStatusDetail(
    status: json['status'] as String,
    dateTime: json['dateTime'] as String,
    dataField: json['dataField'] as String,
    extraFields: (json['extraFields'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderStatusDetailToJson(OrderStatusDetail instance) =>
    <String, dynamic>{
      'status': instance.status,
      'dateTime': instance.dateTime,
      'dataField': instance.dataField,
      'extraFields': instance.extraFields,
    };

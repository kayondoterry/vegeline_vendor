// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) {
  return Vendor(
    vendorId: json['vendorId'] as String,
    fullName: json['fullName'] as String,
    businessName: json['businessName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    vendorType: json['vendorType'] as String,
    location: json['location'] as String,
    NIN: json['NIN'] as String,
    businessDescription: json['businessDescription'] as String,
    imageBase64: json['imageBase64'] as String,
    imageURL: json['imageURL'] as String,
  );
}

Map<String, dynamic> _$VendorToJson(Vendor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('vendorId', instance.vendorId);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('businessName', instance.businessName);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('vendorType', instance.vendorType);
  writeNotNull('location', instance.location);
  writeNotNull('NIN', instance.NIN);
  writeNotNull('businessDescription', instance.businessDescription);
  writeNotNull('imageBase64', instance.imageBase64);
  writeNotNull('imageURL', instance.imageURL);
  return val;
}

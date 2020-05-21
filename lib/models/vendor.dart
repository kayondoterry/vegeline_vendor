import 'package:json_annotation/json_annotation.dart';

part 'vendor.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Vendor {

//  static vendorIdToJson(vId) => null;
//
//  @JsonKey(toJson: vendorIdToJson)
  String vendorId;
  String fullName;
  String businessName;
//  TODO: decide whether categories should be a list or set
//  Set<String> categories;
  String phoneNumber;
  String vendorType;
  String location;
  String NIN;
  String businessDescription;
  String imageBase64;
  String imageURL;

  Vendor({this.vendorId, this.fullName, this.businessName, this.phoneNumber,
    this.vendorType, this.location, this.NIN, this.businessDescription,this.imageBase64, this.imageURL,});

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}

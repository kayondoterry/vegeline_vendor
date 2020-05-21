//import 'package:json_annotation/json_annotation.dart';

//part 'category.g.dart';

//@JsonSerializable(explicitToJson: true)
class Category {
//  final String categoryId;
//  final String name;
//
//  const Category({this.categoryId, this.name});
//
//  factory Category.fromJson(Map<String, dynamic> json) =>
//      _$CategoryFromJson(json);
//
//  Map<String, dynamic> toJson() => _$CategoryToJson(this);
static const String MEATS = 'Meats';
static const String DAIRY = 'Dairy';
static const String GRAINS = 'Grains';
static const String POULTRY = 'Poultry';
static const String FRUITS_VEGETABLES = 'Fruits and Vegetables';
static const String TUBERS = 'Tubers';

static const categoryList = [MEATS, DAIRY, FRUITS_VEGETABLES, GRAINS, POULTRY, TUBERS];

}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../brand_vo/brand_vo.dart';
import '../category_vo/category_vo.dart';

part 'product_vo.g.dart';

@JsonSerializable()
class Product extends Equatable {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "category_id")
  final int? categoryId;

  @JsonKey(name: "brand_id")
  final int? brandId;

  @JsonKey(name: "name_en")
  final String? nameEn;

  @JsonKey(name: "name_mm")
  final String? nameMm;

  @JsonKey(name: "slug")
  final String? slug;

  @JsonKey(name: "feature_image")
  final String? featureImage;

  @JsonKey(name: "category")
  final Category? category;

  @JsonKey(name: "brand")
  final Brand? brand;

  const Product({
    required this.id,
    required this.categoryId,
    required this.brandId,
    required this.nameEn,
    required this.nameMm,
    required this.slug,
    required this.featureImage,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        id,
        categoryId,
        brandId,
        nameEn,
        nameMm,
        slug,
        featureImage,
        category,
        brand,
      ];
}

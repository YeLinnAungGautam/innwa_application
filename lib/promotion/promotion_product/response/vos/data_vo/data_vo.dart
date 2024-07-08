import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../promotion_product_vo/promotion_product_vo.dart';

part 'data_vo.g.dart';

@JsonSerializable()
class Data extends Equatable {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name_en")
  final String? nameEn;

  @JsonKey(name: "name_mm")
  final String? nameMm;

  @JsonKey(name: "slug")
  final String? slug;

  @JsonKey(name: "featured_image")
  final String? featuredImage;

  @JsonKey(name: "banner_image")
  final String? bannerImage;

  @JsonKey(name: "description_en")
  final String? descriptionEn;

  @JsonKey(name: "description_mm")
  final String? descriptionMm;

  @JsonKey(name: "published_date")
  final String? publishedDate;

  @JsonKey(name: "promotion_product")
  final List<PromotionProduct>? promotionProduct;

  const Data({
    required this.id,
    required this.nameEn,
    required this.nameMm,
    required this.slug,
    required this.featuredImage,
    required this.bannerImage,
    required this.descriptionEn,
    required this.descriptionMm,
    required this.publishedDate,
    required this.promotionProduct,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameMm,
        slug,
        featuredImage,
        bannerImage,
        descriptionEn,
        descriptionMm,
        publishedDate,
        promotionProduct,
      ];
}

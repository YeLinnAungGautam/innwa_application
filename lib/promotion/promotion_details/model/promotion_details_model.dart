import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion_details_model.g.dart';

@JsonSerializable()
class PromotionDetailsModel extends Equatable {
  const PromotionDetailsModel(
      {required this.id,
      required this.enName,
      required this.mmName,
      required this.slug,
      required this.featuredImage,
      required this.products,
      this.bannerImage,
      this.enDesc,
      this.mmDesc});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String mmName;
  final String slug;
  @JsonKey(name: "featured_image")
  final String featuredImage;
  @JsonKey(name: "banner_image")
  final String? bannerImage;
  @JsonKey(name: "description_en")
  final String? enDesc;
  @JsonKey(name: "description_mm")
  final String? mmDesc;
  @JsonKey(name: "promotion_product")
  final List<PromotionProductModel> products;

  @override
  List<Object?> get props => [
        id,
        enName,
        mmName,
        slug,
        featuredImage,
        bannerImage,
        enDesc,
        mmDesc,
        products
      ];
  Map<String, dynamic> toJson() => _$PromotionDetailsModelToJson(this);

  factory PromotionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionDetailsModelFromJson(json);
}

@JsonSerializable()
class PromotionProductModel extends Equatable {
  const PromotionProductModel(
      {required this.id,
      required this.productPriceId,
      required this.promotionId,
      this.productPrice});
  final int id;
  @JsonKey(name: "product_price_id")
  final int productPriceId;
  @JsonKey(name: "promotion_id")
  final int promotionId;
  @JsonKey(name: "product_price")
  final Map<String, dynamic>? productPrice;
  @override
  List<Object?> get props => [id, productPriceId, promotionId, productPrice];

  Map<String, dynamic> toJson() => _$PromotionProductModelToJson(this);

  factory PromotionProductModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionProductModelFromJson(json);
}

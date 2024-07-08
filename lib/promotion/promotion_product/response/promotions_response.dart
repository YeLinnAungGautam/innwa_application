import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'vos/promotions_vo/promotions_vo.dart';

part "promotions_response.g.dart";

@JsonSerializable()
class PromotionsResponse extends Equatable {
  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "feature_image_path")
  final String? featureImagePath;

  @JsonKey(name: "promotion_banner_image_path")
  final String? promotionBannerImagePath;

  @JsonKey(name: "dis_image_path")
  final String? disImagePath;

  @JsonKey(name: "product_feature_image_path")
  final String? productFeatureImagePath;

  @JsonKey(name: "promotions")
  final Promotions? promotions;

  const PromotionsResponse({
    required this.status,
    required this.featureImagePath,
    required this.promotionBannerImagePath,
    required this.disImagePath,
    required this.productFeatureImagePath,
    required this.promotions,
  });

  factory PromotionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionsResponseToJson(this);

  @override
  List<Object?> get props => [
        status,
        featureImagePath,
        promotionBannerImagePath,
        disImagePath,
        productFeatureImagePath,
        promotions
      ];
}

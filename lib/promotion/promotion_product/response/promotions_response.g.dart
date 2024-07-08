// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionsResponse _$PromotionsResponseFromJson(Map<String, dynamic> json) =>
    PromotionsResponse(
      status: json['status'] as String?,
      featureImagePath: json['feature_image_path'] as String?,
      promotionBannerImagePath: json['promotion_banner_image_path'] as String?,
      disImagePath: json['dis_image_path'] as String?,
      productFeatureImagePath: json['product_feature_image_path'] as String?,
      promotions: json['promotions'] == null
          ? null
          : Promotions.fromJson(json['promotions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionsResponseToJson(PromotionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'feature_image_path': instance.featureImagePath,
      'promotion_banner_image_path': instance.promotionBannerImagePath,
      'dis_image_path': instance.disImagePath,
      'product_feature_image_path': instance.productFeatureImagePath,
      'promotions': instance.promotions,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionDetailsModel _$PromotionDetailsModelFromJson(
        Map<String, dynamic> json) =>
    PromotionDetailsModel(
      id: json['id'] as int,
      enName: json['name_en'] as String,
      mmName: json['name_mm'] as String,
      slug: json['slug'] as String,
      featuredImage: json['featured_image'] as String,
      products: (json['promotion_product'] as List<dynamic>)
          .map((e) => PromotionProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bannerImage: json['banner_image'] as String?,
      enDesc: json['description_en'] as String?,
      mmDesc: json['description_mm'] as String?,
    );

Map<String, dynamic> _$PromotionDetailsModelToJson(
        PromotionDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'slug': instance.slug,
      'featured_image': instance.featuredImage,
      'banner_image': instance.bannerImage,
      'description_en': instance.enDesc,
      'description_mm': instance.mmDesc,
      'promotion_product': instance.products,
    };

PromotionProductModel _$PromotionProductModelFromJson(
        Map<String, dynamic> json) =>
    PromotionProductModel(
      id: json['id'] as int,
      productPriceId: json['product_price_id'] as int,
      promotionId: json['promotion_id'] as int,
      productPrice: json['product_price'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PromotionProductModelToJson(
        PromotionProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_price_id': instance.productPriceId,
      'promotion_id': instance.promotionId,
      'product_price': instance.productPrice,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionProduct _$PromotionProductFromJson(Map<String, dynamic> json) =>
    PromotionProduct(
      id: (json['id'] as num?)?.toInt(),
      promotionId: (json['promotion_id'] as num?)?.toInt(),
      productPriceId: (json['product_price_id'] as num?)?.toInt(),
      productPrice: json['product_price'] == null
          ? null
          : ProductPrice.fromJson(
              json['product_price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionProductToJson(PromotionProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'promotion_id': instance.promotionId,
      'product_price_id': instance.productPriceId,
      'product_price': instance.productPrice,
    };

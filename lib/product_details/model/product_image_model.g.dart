// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImageModel _$ProductImageModelFromJson(Map<String, dynamic> json) =>
    ProductImageModel(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      productPriceId: json['product_price_id'] as int,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ProductImageModelToJson(ProductImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'product_price_id': instance.productPriceId,
      'image': instance.image,
    };

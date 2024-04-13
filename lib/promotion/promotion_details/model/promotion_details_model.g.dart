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
    };

ProductDataModel _$ProductDataModelFromJson(Map<String, dynamic> json) =>
    ProductDataModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ProductDataModelToJson(ProductDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

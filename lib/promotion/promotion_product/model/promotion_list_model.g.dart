// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionListModel _$PromotionListModelFromJson(Map<String, dynamic> json) =>
    PromotionListModel(
      id: json['id'] as int,
      enName: json['name_en'] as String,
      slug: json['slug'] as String,
      image: json['featured_image'] as String,
      promotionProducts: (json['promotion_product'] as List<dynamic>)
          .map((e) => SearchProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      enDesc: json['description_en'] as String?,
      publishedAt: json['published_date'] as String,
      mmName: json['name_mm'] as String?,
      mmDesc: json['description_mm'] as String?,
    );

Map<String, dynamic> _$PromotionListModelToJson(PromotionListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'slug': instance.slug,
      'featured_image': instance.image,
      'description_en': instance.enDesc,
      'description_mm': instance.mmDesc,
      'published_date': instance.publishedAt,
      'promotion_product': instance.promotionProducts,
    };

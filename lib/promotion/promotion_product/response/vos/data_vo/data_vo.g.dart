// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameMm: json['name_mm'] as String?,
      slug: json['slug'] as String?,
      featuredImage: json['featured_image'] as String?,
      bannerImage: json['banner_image'] as String?,
      descriptionEn: json['description_en'] as String?,
      descriptionMm: json['description_mm'] as String?,
      publishedDate: json['published_date'] as String?,
      promotionProduct: (json['promotion_product'] as List<dynamic>?)
          ?.map((e) => PromotionProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_mm': instance.nameMm,
      'slug': instance.slug,
      'featured_image': instance.featuredImage,
      'banner_image': instance.bannerImage,
      'description_en': instance.descriptionEn,
      'description_mm': instance.descriptionMm,
      'published_date': instance.publishedDate,
      'promotion_product': instance.promotionProduct,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      brandId: (json['brand_id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameMm: json['name_mm'] as String?,
      slug: json['slug'] as String?,
      featureImage: json['feature_image'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'brand_id': instance.brandId,
      'name_en': instance.nameEn,
      'name_mm': instance.nameMm,
      'slug': instance.slug,
      'feature_image': instance.featureImage,
      'category': instance.category,
      'brand': instance.brand,
    };

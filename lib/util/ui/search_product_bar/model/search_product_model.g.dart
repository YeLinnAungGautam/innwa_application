// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProductModel _$SearchProductModelFromJson(Map<String, dynamic> json) =>
    SearchProductModel(
      id: (json['id'] as num).toInt(),
      enName: json['name_en'] as String,
      mmName: json['name_mm'] as String?,
      price: PriceModel.fromJson(json['first_price'] as Map<String, dynamic>),
      image: json['feature_image'] as String,
      slug: json['slug'] as String,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchProductModelToJson(SearchProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'first_price': instance.price,
      'feature_image': instance.image,
      'slug': instance.slug,
      'category': instance.category,
      'brand': instance.brand,
    };

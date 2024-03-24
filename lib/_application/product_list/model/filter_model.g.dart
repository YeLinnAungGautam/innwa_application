// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) => FilterModel(
      featureImage: json['product_feature_image_path'] as String,
      disImage: json['dis_image_path'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => FilterCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>)
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      specTypes: (json['spec_types'] as List<dynamic>)
          .map((e) => SpecTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) =>
    <String, dynamic>{
      'product_feature_image_path': instance.featureImage,
      'dis_image_path': instance.disImage,
      'categories': instance.categories,
      'brands': instance.brands,
      'spec_types': instance.specTypes,
    };

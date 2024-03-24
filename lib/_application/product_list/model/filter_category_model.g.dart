// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterCategoryModel _$FilterCategoryModelFromJson(Map<String, dynamic> json) =>
    FilterCategoryModel(
      id: json['id'] as int,
      enName: json['name_en'] as String,
      childCategories: (json['child_category'] as List<dynamic>)
          .map((e) => ChildCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mmName: json['name_mm'] as String?,
    );

Map<String, dynamic> _$FilterCategoryModelToJson(
        FilterCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'child_category': instance.childCategories,
    };

ChildCategoryModel _$ChildCategoryModelFromJson(Map<String, dynamic> json) =>
    ChildCategoryModel(
      id: json['id'] as int,
      parentId: json['parent_category_id'] as int,
      enName: json['name_en'] as String,
      mmName: json['name_mm'] as String?,
    );

Map<String, dynamic> _$ChildCategoryModelToJson(ChildCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_category_id': instance.parentId,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameMm: json['name_mm'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_mm': instance.nameMm,
    };

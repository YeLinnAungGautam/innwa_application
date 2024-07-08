// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameMm: json['name_mm'] as String?,
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_mm': instance.nameMm,
    };

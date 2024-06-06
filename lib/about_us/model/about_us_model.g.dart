// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_us_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsModel _$AboutUsModelFromJson(Map<String, dynamic> json) => AboutUsModel(
      titleEn: json['title_en'] as String,
      descEn: json['description_en'] as String,
      descMm: json['description_mm'] as String,
      titleMm: json['title_,,'] as String?,
    );

Map<String, dynamic> _$AboutUsModelToJson(AboutUsModel instance) =>
    <String, dynamic>{
      'title_en': instance.titleEn,
      'title_,,': instance.titleMm,
      'description_en': instance.descEn,
      'description_mm': instance.descMm,
    };

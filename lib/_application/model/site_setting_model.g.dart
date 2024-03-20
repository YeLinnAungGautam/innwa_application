// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteModel _$SiteModelFromJson(Map<String, dynamic> json) => SiteModel(
      siteLogoPath: json['site_logo_path'] as String,
      favIcon: json['favicon_path'] as String,
      featureImagePath: json['feature_image_path'] as String,
      siteSetting: SiteSettingModel.fromJson(
          json['site_setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SiteModelToJson(SiteModel instance) => <String, dynamic>{
      'site_logo_path': instance.siteLogoPath,
      'favicon_path': instance.favIcon,
      'feature_image_path': instance.featureImagePath,
      'site_setting': instance.siteSetting,
    };

SiteSettingModel _$SiteSettingModelFromJson(Map<String, dynamic> json) =>
    SiteSettingModel(
      id: json['id'] as int,
      titleEn: json['site_title_en'] as String,
      titleMm: json['site_title_mm'] as String,
    );

Map<String, dynamic> _$SiteSettingModelToJson(SiteSettingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'site_title_en': instance.titleEn,
      'site_title_mm': instance.titleMm,
    };

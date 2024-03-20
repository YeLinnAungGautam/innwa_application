// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubBannerModel _$SubBannerModelFromJson(Map<String, dynamic> json) =>
    SubBannerModel(
      id: json['id'] as int,
      image: json['image'] as String,
      bannerLocation: json['banner_location'] as String,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$SubBannerModelToJson(SubBannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'banner_location': instance.bannerLocation,
      'link': instance.link,
    };

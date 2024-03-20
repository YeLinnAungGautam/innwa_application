import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'site_setting_model.g.dart';

@JsonSerializable()
class SiteModel extends Equatable {
  const SiteModel(
      {required this.siteLogoPath,
      required this.favIcon,
      required this.featureImagePath,
      required this.siteSetting});

  @JsonKey(name: "site_logo_path")
  final String siteLogoPath;
  @JsonKey(name: "favicon_path")
  final String favIcon;
  @JsonKey(name: "feature_image_path")
  final String featureImagePath;
  @JsonKey(name: "site_setting")
  final SiteSettingModel siteSetting;

  @override
  List<Object?> get props => [siteLogoPath, favIcon, featureImagePath];

  SiteModel copyWith(
      {String? siteLogoPath,
      String? favIcon,
      String? featureImagePath,
      SiteSettingModel? siteSetting}) {
    return SiteModel(
        siteLogoPath: siteLogoPath ?? this.siteLogoPath,
        favIcon: favIcon ?? this.favIcon,
        featureImagePath: featureImagePath ?? this.featureImagePath,
        siteSetting: siteSetting ?? this.siteSetting);
  }

  Map<String, dynamic> toJson() => _$SiteModelToJson(this);

  factory SiteModel.fromJson(Map<String, dynamic> json) =>
      _$SiteModelFromJson(json);
}

@JsonSerializable()
class SiteSettingModel extends Equatable {
  const SiteSettingModel(
      {required this.id, required this.titleEn, required this.titleMm});

  final int id;
  @JsonKey(name: "site_title_en")
  final String titleEn;
  @JsonKey(name: "site_title_mm")
  final String titleMm;

  @override
  List<Object?> get props => [id, titleEn, titleMm];
  SiteSettingModel copyWith({int? id, String? titleEn, String? titleMm}) {
    return SiteSettingModel(
        id: id ?? this.id,
        titleEn: titleEn ?? this.titleEn,
        titleMm: titleMm ?? this.titleMm);
  }

  Map<String, dynamic> toJson() => _$SiteSettingModelToJson(this);

  factory SiteSettingModel.fromJson(Map<String, dynamic> json) =>
      _$SiteSettingModelFromJson(json);
}

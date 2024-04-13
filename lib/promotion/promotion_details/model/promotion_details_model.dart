import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion_details_model.g.dart';

@JsonSerializable()
class PromotionDetailsModel extends Equatable {
  const PromotionDetailsModel(
      {required this.id,
      required this.enName,
      required this.mmName,
      required this.slug,
      required this.featuredImage,
      this.bannerImage,
      this.enDesc,
      this.mmDesc});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String mmName;
  final String slug;
  @JsonKey(name: "featured_image")
  final String featuredImage;
  @JsonKey(name: "banner_image")
  final String? bannerImage;
  @JsonKey(name: "description_en")
  final String? enDesc;
  @JsonKey(name: "description_mm")
  final String? mmDesc;

  @override
  List<Object?> get props => [
        id,
        enName,
        mmName,
        slug,
        featuredImage,
        bannerImage,
        enDesc,
        mmDesc,
      ];
  Map<String, dynamic> toJson() => _$PromotionDetailsModelToJson(this);

  factory PromotionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionDetailsModelFromJson(json);
}

@JsonSerializable()
class ProductDataModel extends Equatable {
  const ProductDataModel({required this.data});
  final List<Map<String, dynamic>> data;
  @override
  List<Object?> get props => [data];

  Map<String, dynamic> toJson() => _$ProductDataModelToJson(this);
  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDataModelFromJson(json);
}

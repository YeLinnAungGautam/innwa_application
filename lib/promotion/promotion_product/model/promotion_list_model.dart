import 'package:equatable/equatable.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promotion_list_model.g.dart';

@JsonSerializable()
class PromotionListModel extends Equatable {
  const PromotionListModel({
    required this.id,
    required this.enName,
    required this.slug,
    required this.image,
    this.enDesc,
    required this.publishedAt,
    this.mmName,
    this.mmDesc,
  });
  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  final String slug;
  @JsonKey(name: "featured_image")
  final String image;
  @JsonKey(name: "description_en")
  final String? enDesc;
  @JsonKey(name: "description_mm")
  final String? mmDesc;
  @JsonKey(name: "published_date")
  final String publishedAt;

  @override
  List<Object?> get props => [
        id,
        enName,
        mmName,
        slug,
        image,
        enDesc,
        mmDesc,
        publishedAt,
      ];
  Map<String, dynamic> toJson() => _$PromotionListModelToJson(this);

  factory PromotionListModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionListModelFromJson(json);
}

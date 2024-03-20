import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_banner_model.g.dart';

@JsonSerializable()
class SubBannerModel extends Equatable {
  const SubBannerModel({
    required this.id,
    required this.image,
    required this.bannerLocation,
    this.link,
  });

  final int id;
  final String image;
  @JsonKey(name: "banner_location")
  final String bannerLocation;
  final String? link;
  @override
  List<Object?> get props => [id, image, bannerLocation, link];

  SubBannerModel copyWith(
      {int? id, String? image, String? bannerLocation, String? link}) {
    return SubBannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      bannerLocation: bannerLocation ?? this.bannerLocation,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toJson() => _$SubBannerModelToJson(this);

  factory SubBannerModel.fromJson(Map<String, dynamic> json) =>
      _$SubBannerModelFromJson(json);
}

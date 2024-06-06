import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'about_us_model.g.dart';

@JsonSerializable()
class AboutUsModel extends Equatable {
  const AboutUsModel({
    required this.titleEn,
    required this.descEn,
    required this.descMm,
    this.titleMm,
  });
  @JsonKey(name: "title_en")
  final String titleEn;
  @JsonKey(name: "title_,,")
  final String? titleMm;
  @JsonKey(name: "description_en")
  final String descEn;
  @JsonKey(name: "description_mm")
  final String descMm;

  @override
  List<Object?> get props => [titleEn, titleMm, descEn, descMm];
  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);

  factory AboutUsModel.fromJson(Map<String, dynamic> json) =>
      _$AboutUsModelFromJson(json);
}

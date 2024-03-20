import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_model.g.dart';

@JsonSerializable()
class BrandModel extends Equatable {
  const BrandModel(
      {required this.id,
      required this.enName,
      required this.mmName,
      required this.image});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String mmName;
  final String image;

  @override
  List<Object?> get props => [id, enName, mmName, image];

  BrandModel copyWith(
      {int? id, String? enName, String? mmName, String? image}) {
    return BrandModel(
        id: id ?? this.id,
        enName: enName ?? this.enName,
        mmName: mmName ?? this.mmName,
        image: image ?? this.image);
  }

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);
}

//  {
//            "id": 1,
//            "name_en": "Samsung",
//            "name_mm": "ဆမ်ဆောင်း",
//            "image": "202312150829Samsung Logo.png"
//        }
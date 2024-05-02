import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'select_specification_model.g.dart';

@JsonSerializable()
class SelectSpecificationModel extends Equatable {
  const SelectSpecificationModel(
      {required this.id,
      required this.nameEn,
      required this.specificationValues,
      this.naemMm});

  final int id;
  @JsonKey(name: "name_en")
  final String nameEn;
  @JsonKey(name: "name_mm")
  final String? naemMm;
  @JsonKey(name: "specification_value")
  final List<SpecificationvalueModel> specificationValues;

  @override
  List<Object?> get props => [id, nameEn, naemMm, specificationValues];
  Map<String, dynamic> toJson() => _$SelectSpecificationModelToJson(this);

  factory SelectSpecificationModel.fromJson(Map<String, dynamic> json) =>
      _$SelectSpecificationModelFromJson(json);
  SelectSpecificationModel copyWith(
      {int? id,
      String? nameEn,
      ValueGetter<String?>? naemMm,
      List<SpecificationvalueModel>? specificationValues}) {
    return SelectSpecificationModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        naemMm: naemMm != null ? naemMm() : this.naemMm,
        specificationValues: specificationValues ?? this.specificationValues);
  }
}

@JsonSerializable()
final class SpecificationvalueModel extends Equatable {
  const SpecificationvalueModel(
      {required this.id,
      required this.value,
      required this.specificationTypeId,
      this.productPrice,
      this.colorCode});

  final int id;
  final String value;
  @JsonKey(name: "color_code")
  final String? colorCode;
  @JsonKey(name: "specification_type_id")
  final int specificationTypeId;
  final List<int>? productPrice;

  @override
  List<Object?> get props => [id, value, colorCode, specificationTypeId];
  Map<String, dynamic> toJson() => _$SpecificationvalueModelToJson(this);

  factory SpecificationvalueModel.fromJson(Map<String, dynamic> json) =>
      _$SpecificationvalueModelFromJson(json);
  SpecificationvalueModel copyWith(
      {int? id,
      String? value,
      ValueGetter<String?>? colorCode,
      int? specificationTypeId,
      List<int>? productPrice}) {
    return SpecificationvalueModel(
        id: id ?? this.id,
        value: value ?? this.value,
        colorCode: colorCode != null ? colorCode() : this.colorCode,
        specificationTypeId: specificationTypeId ?? this.specificationTypeId,
        productPrice: productPrice ?? this.productPrice);
  }
}

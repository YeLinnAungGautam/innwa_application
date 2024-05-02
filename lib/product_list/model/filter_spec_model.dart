import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_spec_model.g.dart';

@JsonSerializable()
class SpecTypeModel extends Equatable {
  const SpecTypeModel(
      {required this.id,
      required this.enName,
      required this.specificationValue,
      this.mmName});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @JsonKey(name: "specification_value")
  final List<SpecificationValueModel> specificationValue;

  @override
  List<Object?> get props => [id, enName, mmName, specificationValue];

  Map<String, dynamic> toJson() => _$SpecTypeModelToJson(this);

  factory SpecTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SpecTypeModelFromJson(json);
}

@JsonSerializable()
class SpecificationValueModel extends Equatable {
  const SpecificationValueModel(
      {required this.id,
      required this.typeId,
      required this.value,
      this.mmName,
      this.enName,
      this.colorCode});
  final int id;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @JsonKey(name: "name_en")
  final String? enName;
  @JsonKey(name: "specification_type_id")
  final int typeId;
  final String value;
  @JsonKey(name: "color_code")
  final String? colorCode;
  @override
  List<Object?> get props => [id, mmName, enName, typeId, value, colorCode];
  Map<String, dynamic> toJson() => _$SpecificationValueModelToJson(this);

  factory SpecificationValueModel.fromJson(Map<String, dynamic> json) =>
      _$SpecificationValueModelFromJson(json);
}

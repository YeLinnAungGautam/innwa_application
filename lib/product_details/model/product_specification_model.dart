import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_specification_model.g.dart';

@JsonSerializable()
class ProductSpecificationModel extends Equatable {
  const ProductSpecificationModel(
      {required this.id,
      required this.productId,
      required this.productPriceId,
      required this.specificationTypeId,
      required this.specificationValueId,
      required this.specificationType,
      required this.specificationValue});

  final int id;
  @JsonKey(name: "product_id")
  final int productId;
  @JsonKey(name: "product_price_id")
  final int productPriceId;
  @JsonKey(name: "specification_type_id")
  final int specificationTypeId;
  @JsonKey(name: "specification_value_id")
  final int specificationValueId;
  @JsonKey(name: "specification_type")
  final SpecificationTypeModel specificationType;
  @JsonKey(name: "specification_value")
  final SpecificationValueModel specificationValue;

  @override
  List<Object?> get props => [
        id,
        productId,
        productPriceId,
        specificationTypeId,
        specificationValueId
      ];
  Map<String, dynamic> toJson() => _$ProductSpecificationModelToJson(this);

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSpecificationModelFromJson(json);
}

@JsonSerializable()
class SpecificationTypeModel extends Equatable {
  const SpecificationTypeModel(
      {required this.id, required this.mmName, required this.enName});
  final int id;
  @JsonKey(name: "name_mm")
  final String mmName;
  @JsonKey(name: "name_en")
  final String enName;

  @override
  List<Object?> get props => [id, mmName, enName];
  Map<String, dynamic> toJson() => _$SpecificationTypeModelToJson(this);

  factory SpecificationTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SpecificationTypeModelFromJson(json);
}

@JsonSerializable()
class SpecificationValueModel extends Equatable {
  const SpecificationValueModel(
      {required this.id, required this.value, this.colorCode});
  final int id;
  final String value;
  @JsonKey(name: "color_code")
  final String? colorCode;

  @override
  List<Object?> get props => [id, value, colorCode];
  Map<String, dynamic> toJson() => _$SpecificationValueModelToJson(this);

  factory SpecificationValueModel.fromJson(Map<String, dynamic> json) =>
      _$SpecificationValueModelFromJson(json);
}

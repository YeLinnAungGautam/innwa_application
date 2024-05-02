// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_specification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectSpecificationModel _$SelectSpecificationModelFromJson(
        Map<String, dynamic> json) =>
    SelectSpecificationModel(
      id: json['id'] as int,
      nameEn: json['name_en'] as String,
      specificationValues: (json['specification_value'] as List<dynamic>)
          .map((e) =>
              SpecificationvalueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      naemMm: json['name_mm'] as String?,
    );

Map<String, dynamic> _$SelectSpecificationModelToJson(
        SelectSpecificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_mm': instance.naemMm,
      'specification_value': instance.specificationValues,
    };

SpecificationvalueModel _$SpecificationvalueModelFromJson(
        Map<String, dynamic> json) =>
    SpecificationvalueModel(
      id: json['id'] as int,
      value: json['value'] as String,
      specificationTypeId: json['specification_type_id'] as int,
      productPrice: (json['productPrice'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      colorCode: json['color_code'] as String?,
    );

Map<String, dynamic> _$SpecificationvalueModelToJson(
        SpecificationvalueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'color_code': instance.colorCode,
      'specification_type_id': instance.specificationTypeId,
      'productPrice': instance.productPrice,
    };

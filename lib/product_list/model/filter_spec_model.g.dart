// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_spec_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecTypeModel _$SpecTypeModelFromJson(Map<String, dynamic> json) =>
    SpecTypeModel(
      id: (json['id'] as num).toInt(),
      enName: json['name_en'] as String,
      specificationValue: (json['specification_value'] as List<dynamic>)
          .map((e) =>
              SpecificationValueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mmName: json['name_mm'] as String?,
    );

Map<String, dynamic> _$SpecTypeModelToJson(SpecTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'specification_value': instance.specificationValue,
    };

SpecificationValueModel _$SpecificationValueModelFromJson(
        Map<String, dynamic> json) =>
    SpecificationValueModel(
      id: (json['id'] as num).toInt(),
      typeId: (json['specification_type_id'] as num).toInt(),
      value: json['value'] as String,
      mmName: json['name_mm'] as String?,
      enName: json['name_en'] as String?,
      colorCode: json['color_code'] as String?,
    );

Map<String, dynamic> _$SpecificationValueModelToJson(
        SpecificationValueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_mm': instance.mmName,
      'name_en': instance.enName,
      'specification_type_id': instance.typeId,
      'value': instance.value,
      'color_code': instance.colorCode,
    };

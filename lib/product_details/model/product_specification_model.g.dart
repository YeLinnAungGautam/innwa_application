// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_specification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSpecificationModel _$ProductSpecificationModelFromJson(
        Map<String, dynamic> json) =>
    ProductSpecificationModel(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      productPriceId: json['product_price_id'] as int,
      specificationTypeId: json['specification_type_id'] as int,
      specificationValueId: json['specification_value_id'] as int,
      specificationType: SpecificationTypeModel.fromJson(
          json['specification_type'] as Map<String, dynamic>),
      specificationValue: SpecificationValueModel.fromJson(
          json['specification_value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductSpecificationModelToJson(
        ProductSpecificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'product_price_id': instance.productPriceId,
      'specification_type_id': instance.specificationTypeId,
      'specification_value_id': instance.specificationValueId,
      'specification_type': instance.specificationType,
      'specification_value': instance.specificationValue,
    };

SpecificationTypeModel _$SpecificationTypeModelFromJson(
        Map<String, dynamic> json) =>
    SpecificationTypeModel(
      id: json['id'] as int,
      mmName: json['name_mm'] as String,
      enName: json['name_en'] as String,
    );

Map<String, dynamic> _$SpecificationTypeModelToJson(
        SpecificationTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_mm': instance.mmName,
      'name_en': instance.enName,
    };

SpecificationValueModel _$SpecificationValueModelFromJson(
        Map<String, dynamic> json) =>
    SpecificationValueModel(
      id: json['id'] as int,
      value: json['value'] as String,
      colorCode: json['color_code'] as String?,
    );

Map<String, dynamic> _$SpecificationValueModelToJson(
        SpecificationValueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'color_code': instance.colorCode,
    };

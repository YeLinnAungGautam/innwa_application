// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) => SliderModel(
      id: (json['id'] as num).toInt(),
      serialNumber: (json['serial_no'] as num).toInt(),
      link: json['data'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$SliderModelToJson(SliderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serial_no': instance.serialNumber,
      'data': instance.link,
      'type': instance.type,
    };

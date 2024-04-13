// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'township_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TownshipModel _$TownshipModelFromJson(Map<String, dynamic> json) =>
    TownshipModel(
      id: json['id'] as int,
      mmName: json['name_mm'] as String?,
      enName: json['name_en'] as String?,
    );

Map<String, dynamic> _$TownshipModelToJson(TownshipModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_mm': instance.mmName,
      'name_en': instance.enName,
    };

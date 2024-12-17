// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deli_fee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliFeeModel _$DeliFeeModelFromJson(Map<String, dynamic> json) => DeliFeeModel(
      id: (json['id'] as num).toInt(),
      fee: json['fee'] as String,
    );

Map<String, dynamic> _$DeliFeeModelToJson(DeliFeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
    };

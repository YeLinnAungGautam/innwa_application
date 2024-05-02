// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      id: json['id'] as int,
      enName: json['name_en'] as String,
      branch: (json['branch'] as List<dynamic>)
          .map((e) => SubBranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mmName: json['name_mm'] as String?,
    );

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'branch': instance.branch,
    };

SubBranchModel _$SubBranchModelFromJson(Map<String, dynamic> json) =>
    SubBranchModel(
      id: json['id'] as int,
      enName: json['name_en'] as String,
      image: json['image'] as String,
      enAddress: json['address_en'] as String,
      phone: json['phone'] as String,
      servicePhone: json['service_phone'] as String,
      mmName: json['name_mm'] as String?,
      mmAddress: json['address_mm'] as String?,
    );

Map<String, dynamic> _$SubBranchModelToJson(SubBranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.enName,
      'name_mm': instance.mmName,
      'image': instance.image,
      'address_en': instance.enAddress,
      'address_mm': instance.mmAddress,
      'phone': instance.phone,
      'service_phone': instance.servicePhone,
    };

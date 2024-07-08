// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_responce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchesResponse _$BranchesResponseFromJson(Map<String, dynamic> json) =>
    BranchesResponse(
      status: json['status'] as String?,
      branchImagePath: json['branch_image_path'] as String?,
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchesResponseToJson(BranchesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'branch_image_path': instance.branchImagePath,
      'branches': instance.branches,
    };

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../branch_model.dart';

part 'branches_responce.g.dart';
@JsonSerializable()
class BranchesResponse extends Equatable {
  @JsonKey(name :"status")
  String? status;

  @JsonKey(name :"branch_image_path")
  String? branchImagePath;

  @JsonKey(name :"branches")
  List<BranchModel>? branches;

  BranchesResponse({this.status, this.branchImagePath, this.branches});

  factory BranchesResponse.fromJson(Map<String, dynamic> json)=> _$BranchesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BranchesResponseToJson(this);

  @override
  List<Object?> get props => [status, branchImagePath, branches];
}
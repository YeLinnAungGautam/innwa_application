import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_model.g.dart';

@JsonSerializable()
class BranchModel extends Equatable {
  const BranchModel(
      {required this.id,
      required this.enName,
      required this.branch,
      this.mmName});
  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  final List<SubBranchModel> branch;

  @override
  List<Object?> get props => [id, enName, mmName];
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
}

@JsonSerializable()
class SubBranchModel extends Equatable {
  const SubBranchModel(
      {required this.id,
      required this.enName,
      required this.image,
      required this.enAddress,
      required this.phone,
      required this.servicePhone,
      this.mmName,
      this.mmAddress});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  final String image;
  @JsonKey(name: "address_en")
  final String enAddress;
  @JsonKey(name: "address_mm")
  final String? mmAddress;
  final String phone;
  @JsonKey(name: "service_phone")
  final String servicePhone;

  @override
  List<Object?> get props =>
      [id, enName, mmName, image, enAddress, mmAddress, phone, servicePhone];
  Map<String, dynamic> toJson() => _$SubBranchModelToJson(this);

  factory SubBranchModel.fromJson(Map<String, dynamic> json) =>
      _$SubBranchModelFromJson(json);
}

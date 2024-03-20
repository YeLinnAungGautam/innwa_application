import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
final class TagModel extends Equatable {
  const TagModel({required this.id, required this.enName, this.mmName});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @override
  List<Object?> get props => [id, enName, mmName];
  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
  TagModel copyWith({int? id, String? enName, ValueGetter<String?>? mmName}) {
    return TagModel(
        id: id ?? this.id,
        enName: enName ?? this.enName,
        mmName: mmName != null ? mmName() : this.mmName);
  }
}

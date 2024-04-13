import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_model.g.dart';

@JsonSerializable()
class StateModel extends Equatable {
  const StateModel({required this.id, required this.enName, this.mmName});

  final int id;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @JsonKey(name: "name_en")
  final String enName;

  @override
  List<Object?> get props => [id, mmName, enName];
  StateModel copyWith({int? id, ValueGetter<String?>? mmName, String? enName}) {
    return StateModel(
        id: id ?? this.id,
        mmName: mmName != null ? mmName() : this.mmName,
        enName: enName ?? this.enName);
  }

  Map<String, dynamic> toJson() => _$StateModelToJson(this);

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);
}

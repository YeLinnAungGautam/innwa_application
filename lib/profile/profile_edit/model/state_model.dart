import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_model.g.dart';

@JsonSerializable()
class StateModel extends Equatable {
  const StateModel({required this.id, this.mmName, this.enName});
  final int id;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @JsonKey(name: "name_en")
  final String? enName;

  @override
  List<Object?> get props => [id, mmName, enName];
  Map<String, dynamic> toJson() => _$StateModelToJson(this);

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);
}

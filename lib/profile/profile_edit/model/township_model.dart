import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'township_model.g.dart';

@JsonSerializable()
class TownshipModel extends Equatable {
  const TownshipModel({required this.id, this.mmName, this.enName});
  final int id;
  @JsonKey(name: "name_mm")
  final String? mmName;
  @JsonKey(name: "name_en")
  final String? enName;

  @override
  List<Object?> get props => [id, mmName, enName];
  Map<String, dynamic> toJson() => _$TownshipModelToJson(this);

  factory TownshipModel.fromJson(Map<String, dynamic> json) =>
      _$TownshipModelFromJson(json);
}

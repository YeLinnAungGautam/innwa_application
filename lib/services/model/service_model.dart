import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel extends Equatable {
  const ServiceModel(
      {required this.id, required this.enName, required this.mmName});

  final int id;
  @JsonKey(name: "name_en")
  final String enName;
  @JsonKey(name: "name_mm")
  final String mmName;

  @override
  List<Object?> get props => [id, enName, mmName];
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
  ServiceModel copyWith({int? id, String? enName, String? mmName}) {
    return ServiceModel(
        id: id ?? this.id,
        enName: enName ?? this.enName,
        mmName: mmName ?? this.mmName);
  }
}

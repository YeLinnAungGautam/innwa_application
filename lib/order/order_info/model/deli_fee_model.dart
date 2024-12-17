import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deli_fee_model.g.dart';

@JsonSerializable()
class DeliFeeModel extends Equatable {
  const DeliFeeModel({required this.id, required this.fee});
  final int id;
  final String fee;

  @override
  List<Object?> get props => [id, fee];
  Map<String, dynamic> toJson() => _$DeliFeeModelToJson(this);

  factory DeliFeeModel.fromJson(Map<String, dynamic> json) =>
      _$DeliFeeModelFromJson(json);
}

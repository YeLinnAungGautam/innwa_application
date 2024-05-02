import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "payment_model.g.dart";

@JsonSerializable()
class PaymentModel extends Equatable {
  const PaymentModel({required this.id, required this.name});
  final int id;
  final String name;
  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}

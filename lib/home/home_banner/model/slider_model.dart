import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'slider_model.g.dart';

@JsonSerializable()
class SliderModel extends Equatable {
  const SliderModel(
      {required this.id,
      required this.serialNumber,
      required this.link,
      required this.type});

  final int id;
  @JsonKey(name: "serial_no")
  final int serialNumber;
  @JsonKey(name: "data")
  final String link;
  final String type;

  @override
  List<Object?> get props => [id, serialNumber, link, type];
  SliderModel copyWith(
      {int? id, int? serialNumber, String? link, String? type}) {
    return SliderModel(
      id: id ?? this.id,
      serialNumber: serialNumber ?? this.serialNumber,
      link: link ?? this.link,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() => _$SliderModelToJson(this);

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);
}

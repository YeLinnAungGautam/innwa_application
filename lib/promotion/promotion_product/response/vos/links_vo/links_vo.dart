import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'links_vo.g.dart';

@JsonSerializable()
class Links extends Equatable {
  @JsonKey(name: "url")
  final String? url;

  @JsonKey(name: "label")
  final String? label;

  @JsonKey(name: "active")
  final bool? active;

  const Links({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);

  @override
  List<Object?> get props => [url, label, active];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../data_vo/data_vo.dart';
import '../links_vo/links_vo.dart';

part 'promotions_vo.g.dart';

@JsonSerializable()
class Promotions extends Equatable {
  @JsonKey(name: "current_page")
  final int? currentPage;

  @JsonKey(name: "data")
  final List<Data>? data;

  @JsonKey(name: "first_page_url")
  final String? firstPageUrl;

  @JsonKey(name: "from")
  final int? from;

  @JsonKey(name: "last_page")
  final int? lastPage;

  @JsonKey(name: "last_page_url")
  final String? lastPageUrl;

  @JsonKey(name: "links")
  final List<Links>? links;

  @JsonKey(name: "next_page_url")
  final String? nextPageUrl;

  @JsonKey(name: "path")
  final String? path;

  @JsonKey(name: "per_page")
  final int? perPage;

  @JsonKey(name: "prev_page_url")
  final String? prevPageUrl;

  @JsonKey(name: "to")
  final int? to;

  @JsonKey(name: "total")
  final int? total;

   const Promotions({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Promotions.fromJson(Map<String, dynamic> json) =>
      _$PromotionsFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionsToJson(this);

  @override
  List<Object?> get props => [
        currentPage,
        data,
        firstPageUrl,
        from,
        lastPage,
        lastPageUrl,
        links,
        nextPageUrl,
        path,
        perPage,
        prevPageUrl,
        to,
        total,
      ];
}

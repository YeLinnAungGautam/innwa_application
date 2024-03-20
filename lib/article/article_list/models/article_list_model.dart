import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_list_model.g.dart';

@JsonSerializable()
class ArticleListModel extends Equatable {
  const ArticleListModel(
      {required this.id,
      required this.enName,
      required this.slug,
      required this.image,
      required this.enDesc,
      required this.publisedAt,
      this.mmName,
      this.mmDesc});

  final int id;
  @JsonKey(name: "title_en")
  final String enName;
  @JsonKey(name: "title_mm")
  final String? mmName;
  final String slug;
  final String image;
  @JsonKey(name: "description_en")
  final String enDesc;
  @JsonKey(name: "description_mm")
  final String? mmDesc;
  @JsonKey(name: "published_at")
  final String publisedAt;
  @override
  List<Object?> get props =>
      [id, enName, mmName, slug, image, enDesc, mmDesc, publisedAt];
  ArticleListModel copyWith(
      {int? id,
      String? enName,
      ValueGetter<String?>? mmName,
      String? slug,
      String? image,
      String? enDesc,
      ValueGetter<String?>? mmDesc,
      String? publisedAt}) {
    return ArticleListModel(
        id: id ?? this.id,
        enName: enName ?? this.enName,
        mmName: mmName != null ? mmName() : this.mmName,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        enDesc: enDesc ?? this.enDesc,
        mmDesc: mmDesc != null ? mmDesc() : this.mmDesc,
        publisedAt: publisedAt ?? this.publisedAt);
  }

  Map<String, dynamic> toJson() => _$ArticleListModelToJson(this);

  factory ArticleListModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleListModelFromJson(json);
}

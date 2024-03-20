// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleListModel _$ArticleListModelFromJson(Map<String, dynamic> json) =>
    ArticleListModel(
      id: json['id'] as int,
      enName: json['title_en'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      enDesc: json['description_en'] as String,
      publisedAt: json['published_at'] as String,
      mmName: json['title_mm'] as String?,
      mmDesc: json['description_mm'] as String?,
    );

Map<String, dynamic> _$ArticleListModelToJson(ArticleListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_en': instance.enName,
      'title_mm': instance.mmName,
      'slug': instance.slug,
      'image': instance.image,
      'description_en': instance.enDesc,
      'description_mm': instance.mmDesc,
      'published_at': instance.publisedAt,
    };

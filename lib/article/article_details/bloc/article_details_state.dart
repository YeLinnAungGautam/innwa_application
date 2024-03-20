part of 'article_details_bloc.dart';

class ArticleDetailsState extends Equatable {
  const ArticleDetailsState({
    this.apiStatus = ApiStatus.processing,
    this.imagePrefix = "",
    this.artilce,
    this.latestArticles = const [],
    this.newTags = const [],
    this.tags = const [],
  });
  final ApiStatus apiStatus;
  final String imagePrefix;
  final ArticleListModel? artilce;
  final List<ArticleListModel> latestArticles;
  final List<TagModel> newTags;
  final List<TagModel> tags;

  @override
  List<Object?> get props => [
        apiStatus,
        imagePrefix,
        artilce,
        latestArticles,
        newTags,
        tags,
      ];

  ArticleDetailsState copyWith({
    ApiStatus? apiStatus,
    String? imagePrefix,
    ArticleListModel? artilce,
    List<ArticleListModel>? latestArticles,
    List<TagModel>? newTags,
    List<TagModel>? tags,
  }) {
    return ArticleDetailsState(
      apiStatus: apiStatus ?? this.apiStatus,
      imagePrefix: imagePrefix ?? this.imagePrefix,
      artilce: artilce ?? this.artilce,
      latestArticles: latestArticles ?? this.latestArticles,
      newTags: newTags ?? this.newTags,
      tags: tags ?? this.tags,
    );
  }
}

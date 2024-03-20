part of 'article_list_bloc.dart';

class ArticleListState extends Equatable {
  ArticleListState({this.imagePath, this.nextPageUrl});

  final String? imagePath;
  String? nextPageUrl;

  ArticleListState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  @override
  List<Object?> get props => [
        imagePath,
        nextPageUrl,
      ];
  ArticleListState copyWith({String? imagePath, String? nextPageUrl}) {
    return ArticleListState(
      imagePath: imagePath ?? this.imagePath,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }
}

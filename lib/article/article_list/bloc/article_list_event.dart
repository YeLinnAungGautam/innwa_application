part of 'article_list_bloc.dart';

sealed class ArticleListEvent extends Equatable {
  const ArticleListEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetArticleEvent extends ArticleListEvent {
  const GetArticleEvent({required super.context, required this.pageKey});
  final int pageKey;
}

part of 'article_details_bloc.dart';

sealed class ArticleDetailsEvent extends Equatable {
  const ArticleDetailsEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetArticleDetailsEvent extends ArticleDetailsEvent {
  const GetArticleDetailsEvent({required super.context, required this.slug});
  final String slug;
}

part of 'product_search_bloc.dart';

sealed class ProductSearchEvent extends Equatable {
  const ProductSearchEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class UpdateHasFocusEvent extends ProductSearchEvent {
  const UpdateHasFocusEvent({required super.context, required this.data});
  final bool data;
}

final class CloseSearchBoxEvent extends ProductSearchEvent {
  const CloseSearchBoxEvent({required super.context});
}

final class SearchProductEvent extends ProductSearchEvent {
  const SearchProductEvent({required super.context, required this.pageKey});
  final int pageKey;
}

final class UpdateSearchTextEvent extends ProductSearchEvent {
  const UpdateSearchTextEvent({required super.context, required this.data});
  final String data;
}

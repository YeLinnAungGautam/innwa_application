part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetShopEvent extends ProductListEvent {
  const GetShopEvent({required super.context});
}

final class FilterProductEvent extends ProductListEvent {
  const FilterProductEvent({required super.context, required this.pageKey});
  final int pageKey;
}

final class ShowFilterBottomsheetEvent extends ProductListEvent {
  const ShowFilterBottomsheetEvent({required super.context});
}

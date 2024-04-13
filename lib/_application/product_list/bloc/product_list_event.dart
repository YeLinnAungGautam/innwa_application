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

final class UpdateSelectedTitleEvent extends ProductListEvent {
  const UpdateSelectedTitleEvent({required super.context, required this.data});
  final int data;
}

final class UpdateSelectedCategoryTabEvent extends ProductListEvent {
  const UpdateSelectedCategoryTabEvent(
      {required super.context, required this.data});
  final int data;
}

final class UpdateSelectedBrandsTabEvent extends ProductListEvent {
  const UpdateSelectedBrandsTabEvent(
      {required super.context, required this.data});
  final int data;
}

final class UpdateSelectedSpecificationsTabEvent extends ProductListEvent {
  const UpdateSelectedSpecificationsTabEvent({
    required super.context,
    required this.data,
  });
  final int data;
}

final class UpdateFilterSelectedCategoryEvent extends ProductListEvent {
  const UpdateFilterSelectedCategoryEvent(
      {required super.context, required this.slectedId});
  final int slectedId;
}

final class UpdateFilterSelectedBrandEvent extends ProductListEvent {
  const UpdateFilterSelectedBrandEvent(
      {required super.context, required this.slectedId});
  final int slectedId;
}

final class UpdateFilterSelectedSpecEvent extends ProductListEvent {
  const UpdateFilterSelectedSpecEvent(
      {required super.context, required this.slectedId});
  final int slectedId;
}

final class ClickApplyBtnEvent extends ProductListEvent {
  const ClickApplyBtnEvent({required super.context});
}

final class ClickClearBtnEvent extends ProductListEvent {
  const ClickClearBtnEvent({required super.context});
}

final class SetUsedToSelectedEvent extends ProductListEvent {
  const SetUsedToSelectedEvent({required super.context});
}

final class ClearNextPageUrlEvent extends ProductListEvent {
  const ClearNextPageUrlEvent({required super.context});
}

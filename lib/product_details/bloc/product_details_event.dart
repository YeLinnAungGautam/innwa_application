part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent({required this.context});

  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class GetProductDetailsEvent extends ProductDetailsEvent {
  const GetProductDetailsEvent({required super.context, required this.slug});

  final String slug;
}

final class UpdateRatingEvent extends ProductDetailsEvent {
  const UpdateRatingEvent({required super.context, required this.rating});

  final double rating;
}

final class ClickAddReviewEvent extends ProductDetailsEvent {
  const ClickAddReviewEvent({required super.context});
}

final class ClickWishlistBtnEvent extends ProductDetailsEvent {
  const ClickWishlistBtnEvent({
    required super.context,
    required this.productId,
    required this.slug,
    this.isFavorite = false,
  });

  final int productId;
  final String slug;
  final bool isFavorite;
}

final class SelectSpecEvent extends ProductDetailsEvent {
  const SelectSpecEvent({required super.context, required this.spec});

  final SpecificationvalueModel spec;
}

final class ClickSpecConfirmEvent extends ProductDetailsEvent {
  const ClickSpecConfirmEvent({required super.context, required this.buyNow});

  final bool buyNow;
}

final class ToggleFavoriteEvent extends ProductDetailsEvent {
  const ToggleFavoriteEvent({
    required super.context,
    this.isFavorite = false,
  });
  final bool isFavorite;
}

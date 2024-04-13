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

final class UpdateSelectedSpecEvent extends ProductDetailsEvent {
  const UpdateSelectedSpecEvent({required super.context, required this.id});
  final int id;
}

final class UpdateRatingEvent extends ProductDetailsEvent {
  const UpdateRatingEvent({required super.context, required this.rating});
  final double rating;
}

final class ClickAddReviewEvent extends ProductDetailsEvent {
  const ClickAddReviewEvent({required super.context});
}

final class ClickWishlistBtnEvent extends ProductDetailsEvent {
  const ClickWishlistBtnEvent({required super.context});
}

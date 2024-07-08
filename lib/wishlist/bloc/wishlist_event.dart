part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent({required this.context});

  final BuildContext context;

  @override
  List<Object> get props => [];
}

final class GetWishlistEvent extends WishlistEvent {
  const GetWishlistEvent({required super.context, this.pageKey});
  final int? pageKey;
}

part of 'promotion_details_bloc.dart';

sealed class PromotionDetailsEvent extends Equatable {
  const PromotionDetailsEvent();

  @override
  List<Object> get props => [];
}

final class GetPromotionDetailsEvent extends PromotionDetailsEvent {
  const GetPromotionDetailsEvent({
    required this.slug,
    this.pageKey,
  });
  final String slug;
  final int? pageKey;
}

final class GetPromotionDetailsMoreEvent extends PromotionDetailsEvent {
  const GetPromotionDetailsMoreEvent({
    required this.slug,
    this.pageKey,
  });
  final String slug;
  final int? pageKey;
}

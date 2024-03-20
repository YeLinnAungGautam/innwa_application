part of 'promotion_product_bloc.dart';

sealed class PromotionProductEvent extends Equatable {
  const PromotionProductEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetPromotionProductEvent extends PromotionProductEvent {
  const GetPromotionProductEvent({required super.context});
}

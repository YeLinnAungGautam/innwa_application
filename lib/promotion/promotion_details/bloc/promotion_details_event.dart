part of 'promotion_details_bloc.dart';

sealed class PromotionDetailsEvent extends Equatable {
  const PromotionDetailsEvent({required this.context});
  final BuildContext context;
  @override
  List<Object> get props => [];
}

final class GetPromotionDetailsEvent extends PromotionDetailsEvent {
  const GetPromotionDetailsEvent({required super.context, required this.slug});
  final String slug;
}

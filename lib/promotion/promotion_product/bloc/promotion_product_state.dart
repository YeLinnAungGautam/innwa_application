part of 'promotion_product_bloc.dart';

class PromotionProductState extends Equatable {
  PromotionProductState({
    this.promotionImagePath = "",
    this.nextPageUrl,
  });

  String? nextPageUrl;
  final String? promotionImagePath;

  @override
  List<Object?> get props => [
        nextPageUrl,
        promotionImagePath,
      ];

  PromotionProductState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  PromotionProductState copyWith({
    String? nextPageUrl,
    String? promotionImagePath,
  }) {
    return PromotionProductState(
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      promotionImagePath: promotionImagePath ?? this.promotionImagePath,
    );
  }
}

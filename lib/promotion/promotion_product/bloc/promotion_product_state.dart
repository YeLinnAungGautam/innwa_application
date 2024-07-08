part of 'promotion_product_bloc.dart';

class PromotionProductState extends Equatable {
  PromotionProductState({
    this.promotionImagePath = "",
    this.nextPageUrl,
    this.productImagePath = '',
  });

  String? nextPageUrl;
  final String? promotionImagePath;
  final String? productImagePath;

  @override
  List<Object?> get props => [
        nextPageUrl,
        promotionImagePath,
        productImagePath,
      ];

  PromotionProductState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  PromotionProductState copyWith(
      {String? nextPageUrl,
      String? promotionImagePath,
      String? productImagePath}) {
    return PromotionProductState(
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      promotionImagePath: promotionImagePath ?? this.promotionImagePath,
      productImagePath: productImagePath ?? this.productImagePath,
    );
  }
}

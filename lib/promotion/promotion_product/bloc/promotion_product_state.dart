part of 'promotion_product_bloc.dart';

class PromotionProductState extends Equatable {
  PromotionProductState({
    this.productGetState = ApiStatus.processing,
    this.productImagePath,
    this.promotionImagePath = "",
    this.products = const [],
    this.nextPageUrl,
  });
  final ApiStatus productGetState;
  final String? productImagePath;
  final List<ProductModel> products;
  String? nextPageUrl;
  final String? promotionImagePath;

  @override
  List<Object?> get props => [
        productGetState,
        productImagePath,
        products,
        nextPageUrl,
        promotionImagePath,
      ];

  PromotionProductState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  PromotionProductState copyWith({
    ApiStatus? productGetState,
    String? productImagePath,
    List<ProductModel>? products,
    String? nextPageUrl,
    String? promotionImagePath,
  }) {
    return PromotionProductState(
      productGetState: productGetState ?? this.productGetState,
      productImagePath: productImagePath ?? this.productImagePath,
      products: products ?? this.products,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      promotionImagePath: promotionImagePath ?? this.promotionImagePath,
    );
  }
}

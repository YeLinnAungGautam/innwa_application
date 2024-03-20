part of 'promotion_product_bloc.dart';

class PromotionProductState extends Equatable {
  const PromotionProductState({
    this.productGetState = ApiStatus.processing,
    this.productImagePath,
    this.products = const [],
  });
  final ApiStatus productGetState;
  final String? productImagePath;
  final List<ProductModel> products;
  @override
  List<Object?> get props => [
        productGetState,
        productImagePath,
        products,
      ];

  PromotionProductState copyWith({
    ApiStatus? productGetState,
    String? productImagePath,
    List<ProductModel>? products,
  }) {
    return PromotionProductState(
      productGetState: productGetState ?? this.productGetState,
      productImagePath: productImagePath ?? this.productImagePath,
      products: products ?? this.products,
    );
  }
}

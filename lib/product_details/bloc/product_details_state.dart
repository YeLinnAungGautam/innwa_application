part of 'product_details_bloc.dart';

class ProductDetailsState extends Equatable {
  const ProductDetailsState({
    this.apiStatus = ApiStatus.processing,
    this.productImagepath = "",
    this.disImagePath = "",
    this.featureImagePath = "",
    this.productDetails,
    this.canReview,
    this.orderedProducts = const [],
    this.reviews = const [],
    this.relatedProducts = const [],
    this.selectedSpec,
  });

  final ApiStatus apiStatus;
  final ProductDetailsModel? productDetails;
  final String productImagepath;
  final String disImagePath;
  final List reviews;
  final String? canReview;
  final List<ProductModel> orderedProducts;
  final List<ProductModel> relatedProducts;
  final int? selectedSpec;

  final String featureImagePath;
  @override
  List<Object?> get props => [
        apiStatus,
        productDetails,
        productImagepath,
        disImagePath,
        reviews,
        featureImagePath,
        canReview,
        orderedProducts,
        relatedProducts,
        selectedSpec,
      ];

  ProductDetailsState copyWith({
    ApiStatus? apiStatus,
    ValueGetter<ProductDetailsModel?>? productDetails,
    String? productImagepath,
    String? disImagePath,
    String? featureImagePath,
    List? reviews,
    String? canReview,
    List<ProductModel>? orderedProducts,
    List<ProductModel>? relatedProducts,
    int? selectedSpec,
  }) {
    return ProductDetailsState(
      apiStatus: apiStatus ?? this.apiStatus,
      productDetails:
          productDetails != null ? productDetails() : this.productDetails,
      productImagepath: productImagepath ?? this.productImagepath,
      disImagePath: disImagePath ?? this.disImagePath,
      featureImagePath: featureImagePath ?? this.featureImagePath,
      reviews: reviews ?? this.reviews,
      canReview: canReview ?? this.canReview,
      orderedProducts: orderedProducts ?? this.orderedProducts,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      selectedSpec: selectedSpec ?? this.selectedSpec,
    );
  }
}

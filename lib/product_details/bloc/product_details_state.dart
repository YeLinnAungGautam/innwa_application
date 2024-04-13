part of 'product_details_bloc.dart';

class ProductDetailsState extends Equatable {
  const ProductDetailsState({
    this.apiStatus = ApiStatus.processing,
    this.productImagepath = "",
    this.disImagePath = "",
    this.featureImagePath = "",
    this.productDetails,
    this.canReview = true,
    this.orderedProducts = const [],
    this.reviews = const [],
    this.relatedProducts = const [],
    this.selectedSpec,
    this.ratingAddStatus = ApiStatus.completed,
    this.rating = 4.0,
    this.wishlistApiStatus = ApiStatus.completed,
  });

  final ApiStatus apiStatus;
  final ProductDetailsModel? productDetails;
  final String productImagepath;
  final String disImagePath;
  final List<ReviewModel> reviews;
  final bool? canReview;
  final List<ProductModel> orderedProducts;
  final List<ProductModel> relatedProducts;
  final int? selectedSpec;
  final double rating;
  final ApiStatus? ratingAddStatus;

  final ApiStatus wishlistApiStatus;

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
        ratingAddStatus,
        rating,
        wishlistApiStatus,
      ];

  ProductDetailsState copyWith({
    ApiStatus? apiStatus,
    ValueGetter<ProductDetailsModel?>? productDetails,
    String? productImagepath,
    String? disImagePath,
    String? featureImagePath,
    List<ReviewModel>? reviews,
    bool? canReview,
    List<ProductModel>? orderedProducts,
    List<ProductModel>? relatedProducts,
    int? selectedSpec,
    ApiStatus? ratingAddStatus,
    double? rating,
    ApiStatus? wishlistApiStatus,
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
      ratingAddStatus: ratingAddStatus ?? this.ratingAddStatus,
      rating: rating ?? this.rating,
      wishlistApiStatus: wishlistApiStatus ?? this.wishlistApiStatus,
    );
  }
}

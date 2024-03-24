part of 'promotion_details_bloc.dart';

class PromotionDetailsState extends Equatable {
  const PromotionDetailsState({
    this.apiStatus = ApiStatus.processing,
    this.bannerImagePath = "",
    this.disImagePath = "",
    this.featureImagepath = "",
    this.promotionDetails,
    this.promotionsProducts = const [],
  });

  final ApiStatus apiStatus;
  final String bannerImagePath;
  final String disImagePath;
  final String featureImagepath;
  final PromotionDetailsModel? promotionDetails;
  final List<SearchProductModel> promotionsProducts;
  @override
  List<Object?> get props => [
        apiStatus,
        bannerImagePath,
        disImagePath,
        featureImagepath,
        promotionDetails,
        promotionsProducts,
      ];
  PromotionDetailsState copyWith({
    ApiStatus? apiStatus,
    String? bannerImagePath,
    String? disImagePath,
    String? featureImagepath,
    PromotionDetailsModel? promotionDetails,
    List<SearchProductModel>? promotionsProducts,
  }) {
    return PromotionDetailsState(
      apiStatus: apiStatus ?? this.apiStatus,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      disImagePath: disImagePath ?? this.disImagePath,
      featureImagepath: featureImagepath ?? this.featureImagepath,
      promotionDetails: promotionDetails ?? this.promotionDetails,
      promotionsProducts: promotionsProducts ?? this.promotionsProducts,
    );
  }
}

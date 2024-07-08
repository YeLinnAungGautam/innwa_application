part of 'promotion_details_bloc.dart';

class PromotionDetailsState extends Equatable {
  PromotionDetailsState({
    this.apiStatus = ApiStatus.processing,
    this.bannerImagePath = "",
    this.disImagePath = "",
    this.featureImagepath = "",
    this.promotionsDetail,
    this.products,
    this.total,
    this.nextPageUrl,
    this.data,
  });

  final ApiStatus apiStatus;
  final String bannerImagePath;
  final String disImagePath;
  final String featureImagepath;
  List<PromotionProductData>? data;
  PromotionDetail? promotionsDetail;
  Products? products;
  String? nextPageUrl;
  final int? total;

  @override
  List<Object?> get props => [
        apiStatus,
        bannerImagePath,
        disImagePath,
        featureImagepath,
        promotionsDetail,
        products,
        nextPageUrl,
        total,
        data,
      ];

  PromotionDetailsState clearNextPageUrl() {
    nextPageUrl = null;
    return copyWith();
  }

  PromotionDetailsState copyWith({
    ApiStatus? apiStatus,
    String? bannerImagePath,
    String? disImagePath,
    String? featureImagepath,
    PromotionDetail? promotionDetail,
    Products? products,
    String? nextPageUrl,
    int? total,
    List<PromotionProductData>? data,
  }) {
    return PromotionDetailsState(
        apiStatus: apiStatus ?? this.apiStatus,
        bannerImagePath: bannerImagePath ?? this.bannerImagePath,
        disImagePath: disImagePath ?? this.disImagePath,
        featureImagepath: featureImagepath ?? this.featureImagepath,
        promotionsDetail: promotionDetail ?? promotionsDetail,
        products: products ?? this.products,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        total: total ?? this.total,
        data: data ?? this.data);
  }
}

import "package:equatable/equatable.dart";

class ApiKey {
  ApiKey._();

  static const base = "https://shop.innwa.com.mm/api";
  static const siteSetting = "/site-setting";
  static const slider = "/slider";
  static const latestPhone = "/latest-phone";
  static const latestLaptop = "/latest-laptop";
  static const latestComputer = "/latest-computer";
  static const subBanner = "/sub-banner";
  static const brand = "/brand-slider";
  static const promotionProduct = "/promotion-product";
  static const articles = "/articles";
  static const articleDetails = "//article-detail/";
}

enum ApiStatus {
  processing,
  completed,
  failure,
}

class ApiState extends Equatable {
  const ApiState({this.apiStatus = ApiStatus.processing});
  final ApiStatus apiStatus;

  @override
  List<Object?> get props => [apiStatus];
}

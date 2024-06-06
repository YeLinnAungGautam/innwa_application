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
  static const articleDetails = "/article-detail";
  static const productSearch = "/product-search";
  static const productFilter = "/filter";
  static const promotions = "/promotions";
  static const promotionDetails = "/promotion-detail";
  static const productDetails = "/product-detail";
  static const shop = "/shop";
  static const register = "/customer/register";
  static const login = "/customer/login";
  static const logout = "/customer/logout";
  static const states = "/states";
  static const township = "/get-township";
  static const userUpdate = "/customer/profile";
  static const addReview = "/customer/review";
  static const addRemoveWishList = "/wishlist";
  static const customerWishlist = "/customer/wishlist";
  static const getServices = "/get-services";
  static const bookAppointment = "/book-appointment";
  static const customerOrder = "/customer/my-order";
  static const branches = "/get-branches";
  static const forgetPassword = "/forget-password";
  static const orderFilter = "/customer/order-filter";
  static const deliFee = "/get-deli-fee";
  static const couponList = "/get-coupon";
  static const checkCoupon = "/check-coupon";
  static const paymentMethod = "/get-payment";
  static const order = "/customer/order";
  static const checkToken = "/customer/checkToken";
  static const aboutUs = "/about-us";
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

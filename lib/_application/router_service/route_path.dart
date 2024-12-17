class _PathMap {
  _PathMap(this.path, {required this.fullPath});

  final String fullPath;
  final String path;
}

class RouterPath {
  factory RouterPath() {
    return I;
  }

  RouterPath._();

  static final RouterPath I = RouterPath._();

  final home = _PathMap("/home", fullPath: "/home");
  final promotion = _PathMap("/promotion", fullPath: "/promotion");
  final products = _PathMap("/products", fullPath: "/products");
  final articles = _PathMap("/articles", fullPath: "/articles");
  final about = _PathMap("/about", fullPath: "/about");
  final register = _PathMap("/register", fullPath: "/register");
  final login = _PathMap("/login", fullPath: "/login");
  final forgetPassword =
      _PathMap("/forgetPassword", fullPath: "/forgetPassword");

  final editProfile = _PathMap("/editProfile", fullPath: "/editProfile");

  final articleDetails =
      _PathMap("articleDetails", fullPath: "/articles/articleDetails");
  final promotionsDertails =
      _PathMap("promotionsDetails", fullPath: "/promotion/promotionsDetails");
  final productDetails =
      _PathMap("productDetails", fullPath: "/products/productDetails");
  final rootProductDetails =
      _PathMap("/rootProductDetails", fullPath: "/rootProductDetails");

  final wishList = _PathMap("/wishlist", fullPath: "/wishlist");
  final coupons = _PathMap("/coupons", fullPath: "/coupons");
  final services = _PathMap("/services", fullPath: "/services");
  final orderHisotry = _PathMap("/orderHistory", fullPath: "/orderHistory");
  final cartScreen = _PathMap("/cartScreen", fullPath: "/cartScreen");
  final deliveryInfo = _PathMap("/deliveryInfo", fullPath: "/deliveryInfo");
  final orderInfoScreen = _PathMap("/orderInfo", fullPath: "/orderInfo");
  final paymentSelect = _PathMap("/paymentSelect", fullPath: "/paymentSelect");
  final paymentStatus = _PathMap("/paymentStatus", fullPath: "/paymentStatus");
}

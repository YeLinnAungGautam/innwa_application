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

  final articleDetails =
      _PathMap("articleDetails", fullPath: "/articles/articleDetails");
  final promotionsDertails =
      _PathMap("promotionsDetails", fullPath: "/promotion/promotionsDetails");
  final productDetails =
      _PathMap("productDetails", fullPath: "/products/productDetails");
}

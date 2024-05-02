import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:innwa_mobile_dev/_application/application.dart";
import "package:innwa_mobile_dev/_application/home_navbar.dart";
import "package:innwa_mobile_dev/_application/router_service/route_path.dart";
import "package:innwa_mobile_dev/_application/router_service/router_observer.dart";
import "package:innwa_mobile_dev/about_us/view/about_us.dart";
import "package:innwa_mobile_dev/article/article_details/views/article_detail.dart";
import 'package:innwa_mobile_dev/article/article_list/views/article.dart';
import "package:innwa_mobile_dev/authentication/forget_password/view/forget_password_screen.dart";
import "package:innwa_mobile_dev/authentication/login/views/login.dart";
import "package:innwa_mobile_dev/authentication/register/views/register.dart";
import "package:innwa_mobile_dev/cart/view/cart_screen.dart";
import "package:innwa_mobile_dev/delivery_info/view/delivery_info_screen.dart";
import 'package:innwa_mobile_dev/home/home/home.dart';
import "package:innwa_mobile_dev/order/order_history/view/order_history_screen.dart";
import "package:innwa_mobile_dev/order_info/view/order_info_screen.dart";
import "package:innwa_mobile_dev/payment_select/view/payment_select_screen.dart";
import "package:innwa_mobile_dev/product_details/views/product_detail.dart";
import "package:innwa_mobile_dev/product_list/views/products.dart";
import "package:innwa_mobile_dev/profile/profile_edit/views/profile_edit_screen.dart";
import "package:innwa_mobile_dev/promotion/promotion_details/view/promotion_details_screen.dart";
import "package:innwa_mobile_dev/promotion/promotion_product/view/promotion.dart";
import "package:innwa_mobile_dev/services/view/service_screen.dart";
import "package:innwa_mobile_dev/wishlist/whishlist.dart";

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "root");
final GlobalKey<NavigatorState> homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "home");
final GlobalKey<NavigatorState> promotionKey =
    GlobalKey<NavigatorState>(debugLabel: "promotion");
final GlobalKey<NavigatorState> productKey =
    GlobalKey<NavigatorState>(debugLabel: "product");
final GlobalKey<NavigatorState> articleKey =
    GlobalKey<NavigatorState>(debugLabel: "article");
final GlobalKey<NavigatorState> aboutKey =
    GlobalKey<NavigatorState>(debugLabel: "about");

//   static const List<Widget> _pages = <Widget>[
//     Home(),
//     Promotion(),
//     Products(),
//     Article(),
//     AboutUs()
//   ];
// /// The route configuration.
final GoRouter routerConfig = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: "/",
  debugLogDiagnostics: true,
  observers: [
    GoRouterObserver(),
  ],
  onException: (ctx, state, router) {
    // TODO(jack): do some action when there is no route
    debugPrint(
      "----------------------onException ${state.uri.toString()}----------------------",
    );
    // router.go('/details', extra: state.uri.toString());
  },
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const Application();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.register.path,
      builder: (context, state) {
        return const Register();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.editProfile.path,
      builder: (context, state) {
        return const ProfileEditScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.login.path,
      builder: (context, state) {
        return const Login();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.wishList.path,
      builder: (context, state) {
        return const WishList();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.services.path,
      builder: (context, state) {
        return const ServiceScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.orderHisotry.path,
      builder: (context, state) {
        return const OrderHistoryScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.cartScreen.path,
      builder: (context, state) {
        return const CartScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.deliveryInfo.path,
      builder: (context, state) {
        return const DeliveryInfoScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.rootProductDetails.path,
      builder: (context, state) => ProductDetail(
        slug: state.uri.queryParameters["slug"]!,
      ),
      routes: const [],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.forgetPassword.path,
      builder: (context, state) => const ForgetPasswordScreen(),
      routes: const [],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.orderInfoScreen.path,
      builder: (context, state) => const OrderInfoScreen(),
      routes: const [],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: RouterPath.I.paymentSelect.path,
      builder: (context, state) => const PaymentSelectScreen(),
      routes: const [],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreenNavBar(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // The route branch for the first tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouterPath.I.home.path,
              builder: (context, state) => const Home(),
            ),
          ],
        ),

        // category
        StatefulShellBranch(
          navigatorKey: promotionKey,
          routes: <RouteBase>[
            GoRoute(
                path: RouterPath.I.promotion.path,
                builder: (context, state) => const Promotion(),
                routes: [
                  GoRoute(
                    path: RouterPath.I.promotionsDertails.path,
                    builder: (context, state) => PromotionsDetailsScreen(
                      slug: state.uri.queryParameters["slug"]!,
                    ),
                    routes: const [],
                  ),
                ]),
          ],
        ),
        // Live Chat
        StatefulShellBranch(
          navigatorKey: productKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouterPath.I.products.path,
              builder: (context, state) => const Products(),
              routes: [
                GoRoute(
                  path: RouterPath.I.productDetails.path,
                  builder: (context, state) => ProductDetail(
                    slug: state.uri.queryParameters["slug"]!,
                  ),
                  routes: const [],
                ),
              ],
            ),
          ],
        ),
        // Profile
        StatefulShellBranch(
          navigatorKey: articleKey,
          routes: <RouteBase>[
            GoRoute(
                path: RouterPath.I.articles.path,
                builder: (context, state) => const Article(),
                routes: [
                  GoRoute(
                    path: RouterPath.I.articleDetails.path,
                    builder: (context, state) => ArticleDetail(
                      slug: state.uri.queryParameters["slug"]!,
                    ),
                    routes: const [],
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: aboutKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouterPath.I.about.path,
              builder: (context, state) => const AboutUs(),
            ),
          ],
        ),
      ],
    ),
  ],
);

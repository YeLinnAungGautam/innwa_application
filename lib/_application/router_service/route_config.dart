import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:innwa_mobile_dev/_application/application.dart";
import "package:innwa_mobile_dev/_application/home_navbar.dart";
import "package:innwa_mobile_dev/_application/router_service/route_path.dart";
import "package:innwa_mobile_dev/_application/router_service/router_observer.dart";
import "package:innwa_mobile_dev/article/article_details/views/article_detail.dart";
import 'package:innwa_mobile_dev/article/article_list/views/article.dart';
import 'package:innwa_mobile_dev/home/home/home.dart';
import 'package:innwa_mobile_dev/promotion_product/view/promotion.dart';
import "package:innwa_mobile_dev/screen/aboutus/aboutus.dart";
import "package:innwa_mobile_dev/screen/products/products.dart";

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
            ),
          ],
        ),
        // Live Chat
        StatefulShellBranch(
          navigatorKey: productKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouterPath.I.products.path,
              builder: (context, state) => const Products(),
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

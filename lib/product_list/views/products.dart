import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/product_list/bloc/product_list_bloc.dart';
import 'package:innwa_mobile_dev/product_list/widgets/filter_button.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/view/product_search_app_bar.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductListBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final ProductListBloc productListBloc = BlocProvider.of(context)
          ..add(GetShopEvent(
            context: context,
          ))
          ..listenFilterPagingController(context: context);
        return BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            return Scaffold(
              appBar: TopBar(
                needBackButton: false,
                needMenu: true,
              ),
              drawer: CustomDrawerWidget(
                onDrawerTap: () {},
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  productListBloc
                    ..add(ClearNextPageUrlEvent(context: context))
                    ..add(GetShopEvent(context: context))
                    ..filterProductPagingController.refresh();
                },
                child: CustomScrollView(
                  slivers: [
                    const ProductSearchAppbar(),
                    SliverAppBar(
                      leadingWidth: 0,
                      leading: const SizedBox(),
                      toolbarHeight: 60,
                      pinned: true,
                      centerTitle: true,
                      surfaceTintColor: Colors.transparent,
                      title: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: FilterButton(
                          onClick: () {
                            productListBloc.add(
                                ShowFilterBottomsheetEvent(context: context));
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                    PagedSliverGrid(
                      pagingController:
                          productListBloc.filterProductPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<SearchProductModel>(
                        itemBuilder: (context, item, index) {
                          return ProductCard(
                            product: item,
                            imagePath: state.imagePath,
                          );
                        },
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            MediaQuery.of(context).size.width <= 600
                                ? 0.6
                                : 0.65,
                        crossAxisCount:
                            MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

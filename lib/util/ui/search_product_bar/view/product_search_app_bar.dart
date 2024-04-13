import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/bloc/product_search_bloc.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';

class ProductSearchAppbar extends StatelessWidget {
  const ProductSearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductSearchBloc(BlocProvider.of<AppServiceBloc>(context).api)
            ..listenFocuNode(context: context),
      child: Builder(builder: (context) {
        final ProductSearchBloc productSearchBloc =
            BlocProvider.of<ProductSearchBloc>(context)
              ..listenSearchPagingController(context: context);
        return BlocBuilder<ProductSearchBloc, ProductSearchState>(
          builder: (context, state) {
            return SliverAppBar(
              expandedHeight: 50,
              pinned: true,
              floating: true,
              snap: true,
              surfaceTintColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(state.searchText.isNotEmpty
                    ? MediaQuery.of(context).size.height * 0.8
                    : 70),
                child: Column(
                  children: [
                    LocalizationWidget(
                        en: 'Search Products',
                        mm: 'ထုတ်ကုန်များ ရှာဖွေခြင်း',
                        child: (val) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: TextField(
                              autofocus: false,
                              focusNode: productSearchBloc.focusNode,
                              onChanged: (val) {
                                productSearchBloc.add(UpdateSearchTextEvent(
                                    context: context, data: val));
                                productSearchBloc.debouncer.run(() {
                                  productSearchBloc
                                      .searchProductPagingController
                                      .refresh();
                                });
                              },
                              controller: productSearchBloc.searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: searchColor,
                                focusColor: searchColor,
                                border: InputBorder.none,
                                hintText: val,
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    // Perform the search here
                                  },
                                ),
                                suffixIcon: state.searchText.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          productSearchBloc.focusNode.unfocus();
                                          productSearchBloc.add(
                                              CloseSearchBoxEvent(
                                                  context: context));
                                        },
                                        child: const Icon(Icons.close),
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }),
                    if (state.searchText.isNotEmpty)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height * 0.71,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 10),
                                blurRadius: 30,
                                spreadRadius: 5,
                              )
                            ]),
                        child: CustomScrollView(
                          slivers: [
                            PagedSliverGrid(
                              pagingController: productSearchBloc
                                  .searchProductPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<SearchProductModel>(
                                itemBuilder: (context, item, index) {
                                  return ProductCard(
                                    product: item,
                                    imagePath: state.imagePath,
                                  );
                                },
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 0.6
                                        : 0.65,
                                crossAxisCount:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 2
                                        : 3,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: 50.vertical,
                            ),
                          ],
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

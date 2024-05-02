import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/article/article_list/bloc/article_list_bloc.dart';
import 'package:innwa_mobile_dev/article/article_list/models/article_list_model.dart';
import 'package:innwa_mobile_dev/article/article_list/widgets/article_items.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/view/product_search_app_bar.dart';

class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ArticleListBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final ArticleListBloc articleListBloc =
            BlocProvider.of<ArticleListBloc>(context);

        articleListBloc.listenArticlePagingController(context: context);
        return BlocBuilder<ArticleListBloc, ArticleListState>(
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
                  articleListBloc.add(RefreshEvent(context: context));
                },
                child: CustomScrollView(
                  slivers: [
                    const ProductSearchAppbar(),
                    LocalizationWidget(
                        en: "Articles",
                        mm: "ဆောင်းပါးများ",
                        child: (val) {
                          return SliverAppBar(
                            floating: true,
                            automaticallyImplyLeading: false,
                            snap: true,
                            pinned: true,
                            centerTitle: false,
                            title: RobotoText(
                              fontSize: 18,
                              fontColor: null,
                              fontWeight: FontWeight.w600,
                              text: val,
                            ),
                            actionsIconTheme: const IconThemeData(size: 0),
                            actions: const [Text("")],
                          );
                        }),
                    SliverToBoxAdapter(
                      child: 10.vertical,
                    ),
                    PagedSliverList(
                      pagingController: articleListBloc.artilePagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<ArticleListModel>(
                              itemBuilder: (context, item, index) {
                        return ArticleItems(
                          imagePrefix: state.imagePath!,
                          article: item,
                        );
                      }),
                    )
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/article/article_details/bloc/article_details_bloc.dart';
import 'package:innwa_mobile_dev/article/article_list/models/article_list_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/ui/back_btn.dart';
import 'package:innwa_mobile_dev/util/ui/innwa_error.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({required this.slug, super.key});
  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ArticleDetailsBloc(BlocProvider.of<AppServiceBloc>(context).api)
            ..add(GetArticleDetailsEvent(context: context, slug: slug)),
      child: BlocBuilder<ArticleDetailsBloc, ArticleDetailsState>(
        builder: (context, state) {
          return Scaffold(
              appBar: TopBar(
                needBackButton: false,
                needMenu: true,
                showAction: true,
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: CustomScrollView(
                  slivers: state.apiStatus == ApiStatus.processing
                      ? [
                          const SliverFillRemaining(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ]
                      : state.apiStatus == ApiStatus.completed
                          ? [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      const BackBtn(),
                                      Expanded(
                                        child: Text(
                                          state.artilce!.mmName ??
                                              state.artilce!.enName,
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: 10.vertical,
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: state.imagePrefix +
                                          state.artilce!.image,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: LocalizationWidget(
                                    en: state.artilce!.enDesc,
                                    mm: state.artilce!.mmDesc,
                                    child: (val) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: HtmlWidget(
                                          val,
                                        ),
                                      );
                                    }),
                              ),
                              SliverToBoxAdapter(
                                child: 10.vertical,
                              ),
                              // SliverToBoxAdapter(
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(horizontal: 8),
                              //     child: Wrap(
                              //       children: [
                              //         ...state.newTags.map(
                              //           (e) => Padding(
                              //             padding: const EdgeInsets.only(
                              //               right: 5,
                              //             ),
                              //             child: Text(
                              //               "#${e.mmName ?? e.enName} ${state.newTags.last.id != e.id ? "," : ""}",
                              //               style: const TextStyle(
                              //                 color: Colors.blue,
                              //                 fontSize: 14,
                              //                 fontWeight: FontWeight.bold,
                              //               ),
                              //             ),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // SliverToBoxAdapter(
                              //   child: 10.vertical,
                              // ),
                              SliverToBoxAdapter(
                                child: LocalizationWidget(
                                    en: "Related Articles",
                                    mm: "ဆက်စပ်ဆောင်းပါးများ",
                                    child: (val) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: RobotoText(
                                          fontSize: 16.0,
                                          fontColor: Colors.black,
                                          text: val,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }),
                              ),
                              SliverToBoxAdapter(
                                child: 10.vertical,
                              ),
                              SliverPadding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                sliver: SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: state.latestArticles.length,
                                    (context, index) => GestureDetector(
                                      onTap: () async {
                                        RouterService.of(context).push(
                                            "${RouterPath.I.articleDetails.fullPath}?slug=${state.latestArticles[index].slug}");
                                      },
                                      child: AbsorbPointer(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: state.imagePrefix +
                                                  state.latestArticles[index]
                                                      .image,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                            10.vertical,
                                            LocalizationWidget(
                                                en: state.latestArticles[index]
                                                    .enName,
                                                mm: state.latestArticles[index]
                                                    .mmName,
                                                child: (val) {
                                                  return RobotoText(
                                                    fontSize: 17.0,
                                                    fontColor: Colors.black,
                                                    text: val,
                                                    fontWeight: FontWeight.w600,
                                                  );
                                                }),
                                            10.vertical,
                                            LocalizationWidget(
                                                en: state.latestArticles[index]
                                                    .enDesc,
                                                mm: state.latestArticles[index]
                                                    .mmDesc,
                                                child: (val) {
                                                  final ArticleListModel
                                                      article =
                                                      state.latestArticles[
                                                          index];
                                                  final document = parse(val);
                                                  final String parsedString =
                                                      parse(document.body!.text)
                                                          .documentElement!
                                                          .text;
                                                  return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width <=
                                                                600
                                                            ? 160
                                                            : 400,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 8.0,
                                                        bottom: 8.0,
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    2.0),
                                                        margin: const EdgeInsets
                                                            .only(bottom: 10.0),
                                                        child: RobotoText(
                                                          fontSize: 15.0,
                                                          fontColor:
                                                              Colors.black,
                                                          text: parsedString,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:
                                        MediaQuery.of(context).size.width <= 600
                                            ? 0.6
                                            : 0.65,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width <= 600
                                            ? 2
                                            : 3,
                                  ),
                                ),
                              ),
                              // SliverToBoxAdapter(
                              //   child: 10.vertical,
                              // ),
                              // SliverToBoxAdapter(
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(horizontal: 8),
                              //     child: Wrap(
                              //       children: [
                              //         ...state.tags.map(
                              //           (e) => Padding(
                              //             padding: const EdgeInsets.only(
                              //               right: 5,
                              //             ),
                              //             child: Text(
                              //               "#${e.mmName ?? e.enName} ${state.tags.last.id != e.id ? "," : ""}",
                              //               style: const TextStyle(
                              //                 color: Colors.blue,
                              //                 fontSize: 14,
                              //                 fontWeight: FontWeight.bold,
                              //               ),
                              //             ),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              SliverToBoxAdapter(
                                child: 10.vertical,
                              ),
                            ]
                          : [
                              SliverToBoxAdapter(
                                child: InnwaError(onClick: () {
                                  BlocProvider.of<ArticleDetailsBloc>(context)
                                      .add(GetArticleDetailsEvent(
                                          context: context, slug: slug));
                                }),
                              ),
                            ],
                ),
              ));
        },
      ),
    );
  }
}

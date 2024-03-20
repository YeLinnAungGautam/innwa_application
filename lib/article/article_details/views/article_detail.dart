import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/article/article_details/bloc/article_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

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
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                              child: RobotoText(
                                fontSize: 18.0,
                                fontColor: Colors.black,
                                text: state.artilce!.mmName ??
                                    state.artilce!.enName,
                                fontWeight: FontWeight.bold,
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
                                  imageUrl:
                                      state.imagePrefix + state.artilce!.image,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Html(
                                data: state.artilce!.mmDesc ??
                                    state.artilce!.enDesc,
                              ),
                            ),
                          ),
                        ]
                      : [],
            ),
          ));
        },
      ),
    );
  }
}

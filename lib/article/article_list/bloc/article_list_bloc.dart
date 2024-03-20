import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/article/article_list/models/article_list_model.dart';

part 'article_list_event.dart';
part 'article_list_state.dart';

class ArticleListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  ArticleListBloc(this._restAPI) : super(ArticleListState()) {
    on<GetArticleEvent>(_getArticleEvent);
  }

  final RestAPI _restAPI;
  final PagingController<int, ArticleListModel> artilePagingController =
      PagingController(firstPageKey: 1);

  Future<Map<String, dynamic>?> _getArticles({String? params}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.articles}${params ?? ""}",
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = null;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  Future<void> _getArticleEvent(GetArticleEvent event, Emitter emit) async {
    debugPrint(
        "-----------name---------------------${Uri.parse("https://shop.innwa.com.mm/api/articles?page=1").queryParameters}--------------------------------");

    final resData = await _getArticles(
        params: state.nextPageUrl != null
            ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}"
            : "");

    if (resData != null) {
      emit(state.copyWith(
        imagePath: resData["product_feature_image_path"],
        nextPageUrl: resData["news"]["next_page_url"],
      ));

      if (resData["news"]["next_page_url"] == null ||
          resData["news"]["next_page_url"] == "null") {
        emit(state.clearNextPageUrl());
      } else {
        emit(state.copyWith(
          nextPageUrl: resData["news"]["next_page_url"],
        ));
      }
      final jsonData = resData["news"]["data"] as List;
      final List<ArticleListModel> data =
          jsonData.map((e) => ArticleListModel.fromJson(e)).toList();
      if (state.nextPageUrl == null) {
        artilePagingController.appendLastPage(data);
      } else {
        artilePagingController.appendPage(data, event.pageKey + 1);
      }
    } else {
      artilePagingController.error = "Error";
    }
  }

  void listenArticlePagingController({required BuildContext context}) async {
    artilePagingController.addPageRequestListener((page) {
      add(GetArticleEvent(context: context, pageKey: page));
    });
  }
}

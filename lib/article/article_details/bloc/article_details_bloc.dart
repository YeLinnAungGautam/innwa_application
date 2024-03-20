import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/article/article_list/models/article_list_model.dart';
import 'package:innwa_mobile_dev/article/article_list/models/tag_model.dart';

part 'article_details_event.dart';
part 'article_details_state.dart';

class ArticleDetailsBloc
    extends Bloc<ArticleDetailsEvent, ArticleDetailsState> {
  ArticleDetailsBloc(this._restApi) : super(const ArticleDetailsState()) {
    on<GetArticleDetailsEvent>(_getArticleDetailsEvent);
  }
  final RestAPI _restApi;

  Future<Map<String, dynamic>?> _getArticleDetails(
      {required String slug}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restApi.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.articleDetails}/$slug",
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

  Future<void> _getArticleDetailsEvent(
    GetArticleDetailsEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(apiStatus: ApiStatus.processing));
    final resData = await _getArticleDetails(slug: event.slug);
    if (resData != null) {
      emit(state.copyWith(
        imagePrefix: resData["product_feature_image_path"],
        artilce: ArticleListModel.fromJson(resData["new"]),
        latestArticles: (resData["latestNews"] as List)
            .map((e) => ArticleListModel.fromJson(e))
            .toList(),
        newTags: (resData["new_tag"] as List)
            .map((e) => TagModel.fromJson(e))
            .toList(),
        tags:
            (resData["tags"] as List).map((e) => TagModel.fromJson(e)).toList(),
        apiStatus: ApiStatus.completed,
      ));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.failure));
    }
  }
}

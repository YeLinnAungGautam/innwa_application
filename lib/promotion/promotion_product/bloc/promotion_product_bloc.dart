import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/response/promotions_response.dart';

import '../response/vos/data_vo/data_vo.dart';

part 'promotion_product_event.dart';
part 'promotion_product_state.dart';

class PromotionProductBloc
    extends Bloc<PromotionProductEvent, PromotionProductState> {
  PromotionProductBloc(this._restAPI) : super(PromotionProductState()) {
    on<GetPromotionEvent>(_getPromotionEvent);
  }

  final RestAPI _restAPI;

  PagingController<int, Data> promotionPagingController =
      PagingController(firstPageKey: 1);

  Future<void> _getPromotionEvent(GetPromotionEvent event, Emitter emit) async {
    final resData = await _getPromotions(
        params: state.nextPageUrl != null
            ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}"
            : "?page=1");

    final PromotionsResponse promotionsResponse =
        PromotionsResponse.fromJson(resData ?? {});
    print("promotions list data ==> ${promotionsResponse.status}");

    if (resData != null && promotionsResponse.status == "success") {
      emit(state.copyWith(
        promotionImagePath: promotionsResponse.featureImagePath,
        productImagePath: promotionsResponse.productFeatureImagePath,
        // nextPageUrl: promotionsResponse.promotions?.nextPageUrl,
      ));

      if (promotionsResponse.featureImagePath == null ||
          promotionsResponse.promotions?.nextPageUrl == "null") {
        emit(state.clearNextPageUrl());
      } else {
        emit(state.copyWith(
          nextPageUrl: promotionsResponse.promotions?.nextPageUrl,
        ));
      }

      final List<Data>? listData = promotionsResponse.promotions?.data;
      if (state.nextPageUrl == null) {
        promotionPagingController.appendLastPage(listData ?? []);
      } else {
        promotionPagingController.appendPage(listData ?? [], event.pageKey + 1);
      }
    } else {
      promotionPagingController.error = "Error";
    }
  }

  Future<Map<String, dynamic>?> _getPromotions({String? params}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.promotions + (params ?? ""),
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
        onCallBack: (value, result) async {
          if (!result!) {
            resData = null;
          }
          return result;
        },
      ),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  void listenPromotionPagingController({required BuildContext context}) async {
    if (!promotionPagingController.hasListeners) {
      promotionPagingController.addPageRequestListener((pageKey) {
        add(GetPromotionEvent(context: context, pageKey: pageKey));
      });
    }
  }
}

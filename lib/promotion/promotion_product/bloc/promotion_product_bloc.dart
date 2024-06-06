import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/model/promotion_list_model.dart';

part 'promotion_product_event.dart';
part 'promotion_product_state.dart';

class PromotionProductBloc
    extends Bloc<PromotionProductEvent, PromotionProductState> {
  PromotionProductBloc(this._restAPI) : super(PromotionProductState()) {
    on<GetPromotionEvent>(_getPromotionEvent);
  }
  final RestAPI _restAPI;

  PagingController<int, PromotionListModel> promotionPagingController =
      PagingController(firstPageKey: 1);

  Future<void> _getPromotionEvent(GetPromotionEvent event, Emitter emit) async {
    final resData = await _getPromotions(
        params: state.nextPageUrl != null
            ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}"
            : "");

    if (resData != null) {
      emit(state.copyWith(
        promotionImagePath: resData["feature_image_path"],
        nextPageUrl: resData["promotions"]["next_page_url"],
      ));

      if (resData["promotions"]["next_page_url"] == null ||
          resData["promotions"]["next_page_url"] == "null") {
        emit(state.clearNextPageUrl());
      } else {
        emit(state.copyWith(
          nextPageUrl: resData["promotions"]["next_page_url"],
        ));
      }
      final jsonData = resData["promotions"]["data"] as List;
      for (var element in jsonData) {
        final test = PromotionListModel.fromJson(element);
        debugPrint(
            "-----------Complete---------------------${test.id}--------------------------------");
      }
      final List<PromotionListModel> data =
          jsonData.map((e) => PromotionListModel.fromJson(e)).toList();
      if (state.nextPageUrl == null) {
        promotionPagingController.appendLastPage(data);
      } else {
        promotionPagingController.appendPage(data, event.pageKey + 1);
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

  void listenPromtionPagingController({required BuildContext context}) async {
    if (!promotionPagingController.hasListeners) {
      promotionPagingController.addPageRequestListener((pageKey) {
        add(GetPromotionEvent(context: context, pageKey: pageKey));
      });
    }
  }
}

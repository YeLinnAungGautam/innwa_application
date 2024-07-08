import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/promotion/promotion_details/model/promotionDetailResponse/promotion_detail_response.dart';

part 'promotion_details_event.dart';
part 'promotion_details_state.dart';

class PromotionDetailsBloc
    extends Bloc<PromotionDetailsEvent, PromotionDetailsState> {
  PromotionDetailsBloc(
    this._restAPI,
    this.slug,
  ) : super(PromotionDetailsState()) {
    on<GetPromotionDetailsEvent>(_getPromotionDetailsEvent);
    scrollController = ScrollController()..addListener(loadMoreData);
  }

  final RestAPI _restAPI;

  final String slug;

  late ScrollController scrollController;

  Future<void> _getPromotionDetailsEvent(GetPromotionDetailsEvent event,
      Emitter<PromotionDetailsState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.processing));

    final resData = await _getPromotionsDetails(
      slug: event.slug,
      param: state.nextPageUrl != null
          ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}"
          : "?page=1",
    );

    final PromotionDetailResponse promotionDetailResponse =
        PromotionDetailResponse.fromJson(resData ?? {});
    debugPrint(
        'this is product detail data ${promotionDetailResponse.status}==> $promotionDetailResponse');

    if (promotionDetailResponse.status == "success") {
      emit(
        state.copyWith(
          apiStatus: ApiStatus.completed,
          bannerImagePath: promotionDetailResponse.promotionBannerImagePath,
          disImagePath: promotionDetailResponse.disImagePath,
          featureImagepath: promotionDetailResponse.productFeatureImagePath,
          products: promotionDetailResponse.products,
          promotionDetail: promotionDetailResponse.promotion,
          total: promotionDetailResponse.products?.total,
          data: List.from(state.data ?? [])
            ..addAll(promotionDetailResponse.products?.data ?? []),
        ),
      );

      if (promotionDetailResponse.products?.nextPageUrl == "null" ||
          promotionDetailResponse.products?.nextPageUrl == null) {
        emit(state.clearNextPageUrl());
      } else {
        emit(
          state.copyWith(
            nextPageUrl: promotionDetailResponse.products?.nextPageUrl,
          ),
        );
      }
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.failure));
    }
  }

  /// load more data when user scroll , then api call again if there was nextPageUrl
  void loadMoreData() {
    final isLastPage = (state.data?.length ?? 0) < (state.total ?? 0);
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        isLastPage) {
      add(GetPromotionDetailsEvent(slug: slug));
    }
  }

  /// to request data
  Future<Map<String, dynamic>?> _getPromotionsDetails(
      {required String slug, String? param}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.promotionDetails}/$slug${param ?? ""}",
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

  @override
  Future<void> close() {
    scrollController.removeListener(loadMoreData);
    scrollController.dispose();
    return super.close();
  }
}

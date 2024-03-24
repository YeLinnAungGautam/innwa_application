import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/product_list/model/filter_model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc(this._restAPI) : super(ProductListState()) {
    on<FilterProductEvent>(_filterProductEvent);
    on<GetShopEvent>(_getShopEvent);
  }

  final RestAPI _restAPI;

  final PagingController<int, SearchProductModel>
      filterProductPagingController = PagingController(firstPageKey: 1);

  Future<void> _getShopEvent(GetShopEvent event, Emitter emit) async {
    emit(state.copyWith(shopStatus: ApiStatus.processing));
    final resData = await _getShops();
    if (resData != null) {
      emit(state.copyWith(
        filterData: FilterModel.fromJson(resData),
        shopStatus: ApiStatus.completed,
      ));
    } else {
      emit(state.copyWith(shopStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getShops() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.shop,
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

  Future<Map<String, dynamic>?> _searchProduct(
      {required Map<String, dynamic> data, String? params}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "POST",
      path: ApiKey.productSearch,
      error: error,
      data: data,
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

  Future<void> _filterProductEvent(
      FilterProductEvent event, Emitter emit) async {
    final resData = await _searchProduct(
      params: state.nextPageUrl != null
          ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}"
          : "",
      data: {"keywords": "state.searchText"},
    );

    if (resData != null) {
      emit(state.copyWith(
        imagePath: resData["product_feature_image_path"],
        nextPageUrl: resData["products"]["next_page_url"],
      ));

      if (resData["products"]["next_page_url"] == null ||
          resData["products"]["next_page_url"] == "null") {
        emit(state.clearNextPageUrl());
      } else {
        emit(state.copyWith(
          nextPageUrl: resData["products"]["next_page_url"],
        ));
      }
      final jsonData = resData["products"]["data"] as List;
      final List<SearchProductModel> data =
          jsonData.map((e) => SearchProductModel.fromJson(e)).toList();
      if (state.nextPageUrl == null) {
        filterProductPagingController.appendLastPage(data);
      } else {
        filterProductPagingController.appendPage(data, event.pageKey + 1);
      }
    } else {
      filterProductPagingController.error = "Error";
    }
  }

  void listenFilterPagingController({required BuildContext context}) async {
    filterProductPagingController.addPageRequestListener((page) {
      add(FilterProductEvent(context: context, pageKey: page));
    });
  }
}

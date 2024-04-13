import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/util/debounce.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  ProductSearchBloc(this._restAPI) : super(ProductSearchState()) {
    on<UpdateHasFocusEvent>(_updateHasFocus);
    on<CloseSearchBoxEvent>(_closeSearchBox);
    on<SearchProductEvent>(_searchProductEvent);
    on<UpdateSearchTextEvent>(_updateSearchText);
  }

  final RestAPI _restAPI;
  final TextEditingController searchController = TextEditingController();
  final PagingController<int, SearchProductModel>
      searchProductPagingController = PagingController(firstPageKey: 1);
  final Debouncer debouncer = Debouncer(milliseconds: 300);

  final FocusNode focusNode = FocusNode();

  void _updateSearchText(UpdateSearchTextEvent event, Emitter emit) {
    emit(state.copyWith(searchText: event.data));
  }

  void _closeSearchBox(CloseSearchBoxEvent event, Emitter emit) {
    emit(state.copyWith(searchText: "", hasFocus: false));
    searchController.text = "";
  }

  void _updateHasFocus(UpdateHasFocusEvent event, Emitter emit) {
    emit(state.copyWith(hasFocus: event.data));
  }

  Future<Map<String, dynamic>?> _searchProduct({String? params}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.productSearch}$params",
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

  Future<void> _searchProductEvent(
      SearchProductEvent event, Emitter emit) async {
    final resData = await _searchProduct(
      params: state.nextPageUrl != null
          ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}&keyword=${state.searchText}"
          : "?keyword=${state.searchText}",
    );

    if (resData != null) {
      emit(state.copyWith(
        imagePath: resData["feature_image_path"],
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
        searchProductPagingController.appendLastPage(data);
      } else {
        searchProductPagingController.appendPage(data, event.pageKey + 1);
      }
    } else {
      searchProductPagingController.error = "Error";
    }
  }

  void listenSearchPagingController({required BuildContext context}) async {
    searchProductPagingController.addPageRequestListener((page) {
      add(SearchProductEvent(context: context, pageKey: page));
    });
  }

  void listenFocuNode({required BuildContext context}) {
    focusNode.addListener(() {
      add(UpdateHasFocusEvent(context: context, data: focusNode.hasFocus));
    });
  }
}

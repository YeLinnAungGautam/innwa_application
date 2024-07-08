import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc(this._restAPI) : super(WishlistState()) {
    on<GetWishlistEvent>(_getProductEvent);
  }

  final PagingController<int, SearchProductModel> produtPagingController =
      PagingController(firstPageKey: 1);

  final RestAPI _restAPI;

  Future<void> _getProductEvent(GetWishlistEvent event, Emitter emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.processing));
    final resData = await _getWishlist(
      params: state.nextPageUrl != null
          ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}"
          : "?page=1",
    );

    print("this is wishlist ---> ${resData?['status']}");
    if (resData != null) {
      emit(state.copyWith(
        apiStatus: ApiStatus.completed,
        imagePath: resData["image_path"],
        message: resData['msg'],
      ));

      if (resData["wishlist"]["next_page_url"] == null ||
          resData["wishlist"]["next_page_url"] == "null") {
        emit(state.clearNextPageUrl());
      } else {
        emit(state.copyWith(
          nextPageUrl: resData["wishlist"]["next_page_url"],
        ));
      }
      final jsonData = resData["wishlist"]["data"] as List;

      final List<SearchProductModel> wishListDataList = jsonData
          .map((e) => SearchProductModel.fromJson(e["product"]))
          .toList();

      print(
          "----- wishList is calling -------wishListData ==> $wishListDataList");
      if (wishListDataList.isNotEmpty) {
        final List<String> wishlistSlug = wishListDataList
            .map(
              (e) => e.slug,
            )
            .toList();
        print(
            "----- wishList is calling -------wishList slug from model==> $wishlistSlug");
        emit(state.copyWith(
          wishListData: wishListDataList,
          favoritesSlug: wishlistSlug,
        ));

        // print(
        //     "----- wishList state is calling -------wishList slug from wishlist state ==>${state.favoritesSlug}");
        // print(
        //     "----- wishList state is calling -------wishList apiStatus from wishlist state ==>${state.apiStatus}");
      }

      if (state.nextPageUrl == null) {
        produtPagingController.appendLastPage(wishListDataList);
      } else {
        produtPagingController.appendPage(
            wishListDataList, (event.pageKey ?? 0) + 1);
      }
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.failure));
      produtPagingController.error = "Error";
    }
  }

  Future<Map<String, dynamic>?> _getWishlist({String? params}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.customerWishlist + params!,
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

  void listenFilterPagingController({required BuildContext context}) async {
    produtPagingController.addPageRequestListener((page) {
      add(GetWishlistEvent(context: context, pageKey: page));
    });
  }
}

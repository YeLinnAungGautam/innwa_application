import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/product_details/model/review_model.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc(this._restAPI) : super(const ProductDetailsState()) {
    on<GetProductDetailsEvent>(_getProductDetailsEvent);
    on<UpdateSelectedSpecEvent>(_updateSelectedSpec);
    on<UpdateRatingEvent>(_updateRating);
    on<ClickAddReviewEvent>(_clickAddReviewEvent);
    on<ClickWishlistBtnEvent>(_wishListBtnClick);
  }

  final RestAPI _restAPI;
  final TextEditingController ratingTextController = TextEditingController();
  final GlobalKey<FormState> ratingForm = GlobalKey();

  Future<void> _wishListBtnClick(ClickWishlistBtnEvent event, Emitter emit) async {
    emit(state.copyWith(wishlistApiStatus: ApiStatus.processing));
    final resData =
        await _addRemoveWishList(productId: state.productDetails!.id);
    emit(state.copyWith(wishlistApiStatus: ApiStatus.completed));
    if (resData != null) {
      showSnackBar(
        message: resData["message"],
        title: "Wishlist",
        context: event.context,
        backgroundColor: Colors.green,
        titleColor: Colors.white,
        messageColor: Colors.white,
      );
    }
  }

  Future<Map<String, dynamic>?> _addRemoveWishList({
    required int productId,
  }) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.addRemoveWishList}/$productId",
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

  Future<void> _clickAddReviewEvent(
      ClickAddReviewEvent event, Emitter emit) async {
    final validate = ratingForm.currentState!.validate();
    if (validate) {
      emit(state.copyWith(ratingAddStatus: ApiStatus.processing));
      final resData = await _addReview(data: {
        "stars": int.parse(state.rating.toString().split(".")[0]),
        "msg": ratingTextController.text,
        "product_id": state.productDetails!.id,
      });
      emit(state.copyWith(ratingAddStatus: ApiStatus.completed));
      if (resData != null) {
        emit(state.copyWith(canReview: false, reviews: [
          ...state.reviews,
          ReviewModel(
              id: Random().nextInt(9999),
              productId: state.productDetails!.id,
              customerId:
                  BlocProvider.of<UserBloc>(event.context).state.user!.id,
              star: int.parse(state.rating.toString().split(".")[0]),
              msg: ratingTextController.text),
        ]));

        showSnackBar(
          message: resData["message"],
          title: "Review Success",
          context: event.context,
          backgroundColor: Colors.green,
          titleColor: Colors.white,
          messageColor: Colors.white,
        );
      }
    }
  }

  Future<Map<String, dynamic>?> _addReview(
      {required Map<String, dynamic> data}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "POST",
      path: ApiKey.addReview,
      data: data,
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

  void _updateRating(UpdateRatingEvent event, Emitter emit) {
    emit(state.copyWith(rating: event.rating));
  }

  void _updateSelectedSpec(UpdateSelectedSpecEvent event, Emitter emit) {
    emit(state.copyWith(selectedSpec: event.id));
  }

  Future<void> _getProductDetailsEvent(
      GetProductDetailsEvent event, Emitter emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.processing));
    final resData = await _getProductDetails(slug: event.slug);

    if (resData != null) {
      final jsonReview = resData["reviews"] as List;
      final List<ReviewModel> data =
          jsonReview.map((e) => ReviewModel.fromJson(e)).toList();

      emit(
        state.copyWith(
          apiStatus: ApiStatus.completed,
          productImagepath: resData["product_image_path"],
          disImagePath: resData["dis_image_path"],
          featureImagePath: resData["product_feature_image_path"],
          productDetails: () =>
              ProductDetailsModel.fromJson(resData["product"]),
          reviews: data,
          canReview: data
              .where((element) =>
                  element.customerId ==
                  BlocProvider.of<UserBloc>(event.context).state.user?.id)
              .isEmpty,
          orderedProducts: (resData["ordered_product"] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
          relatedProducts: (resData["related_products"] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList(),
        ),
      );
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getProductDetails({
    required String slug,
  }) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.productDetails}/$slug",
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
        },
      ),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }
}

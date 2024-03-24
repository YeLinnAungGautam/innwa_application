import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc(this._restAPI) : super(const ProductDetailsState()) {
    on<GetProductDetailsEvent>(_getProductDetailsEvent);
    on<UpdateSelectedSpecEvent>(_updateSelectedSpec);
  }

  final RestAPI _restAPI;

  void _updateSelectedSpec(UpdateSelectedSpecEvent event, Emitter emit) {
    emit(state.copyWith(selectedSpec: event.id));
  }

  Future<void> _getProductDetailsEvent(
      GetProductDetailsEvent event, Emitter emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.processing));
    final resData = await _getProductDetails(slug: event.slug);

    if (resData != null) {
      emit(
        state.copyWith(
          apiStatus: ApiStatus.completed,
          productImagepath: resData["product_image_path"],
          disImagePath: resData["dis_image_path"],
          featureImagePath: resData["product_feature_image_path"],
          productDetails: () =>
              ProductDetailsModel.fromJson(resData["product"]),
          reviews: resData["reviews"],
          canReview: resData["can_review"],
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

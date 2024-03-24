import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/promotion/promotion_details/model/promotion_details_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/brand_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/category_model.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';

part 'promotion_details_event.dart';
part 'promotion_details_state.dart';

class PromotionDetailsBloc
    extends Bloc<PromotionDetailsEvent, PromotionDetailsState> {
  PromotionDetailsBloc(this._restAPI) : super(const PromotionDetailsState()) {
    on<GetPromotionDetailsEvent>(_getPromotionDetailsEvent);
  }

  final RestAPI _restAPI;

  Future<void> _getPromotionDetailsEvent(
      GetPromotionDetailsEvent event, Emitter emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.processing));
    final resData = await _getPromotionsDetails(slug: event.slug);
    if (resData != null) {
      emit(
        state.copyWith(
            apiStatus: ApiStatus.completed,
            bannerImagePath: resData["promotion_banner_image_path"],
            disImagePath: resData["dis_image_path"],
            featureImagepath: resData["product_feature_image_path"],
            promotionDetails:
                PromotionDetailsModel.fromJson(resData["promotion"])),
      );

      final List<SearchProductModel> data = [];

      for (var product in state.promotionDetails!.products) {
        if (product.productPrice != null) {
          final promotionProduct = SearchProductModel(
              id: product.productPrice!["id"],
              enName: product.productPrice!["product"]["name_en"],
              mmName: product.productPrice!["product"]["name_mm"],
              price: PriceModel.fromJson(product.productPrice!),
              image: product.productPrice!["product"]["feature_image"],
              slug: product.productPrice!["product"]["slug"],
              category: CategoryModel.fromJson(
                  product.productPrice!["product"]["category"]),
              brand: BrandModel.fromJson(
                  product.productPrice!["product"]["brand"]));
          data.add(promotionProduct);
        }
      }
      emit(state.copyWith(promotionsProducts: data));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getPromotionsDetails(
      {required String slug}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: "${ApiKey.promotionDetails}/$slug",
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
}

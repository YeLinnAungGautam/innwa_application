import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/product_details/model/review_model.dart';
import 'package:innwa_mobile_dev/product_details/model/select_specification_model.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:innwa_mobile_dev/util/ui/snack_bar.dart';
import 'package:innwa_mobile_dev/wishlist/bloc/wishlist_bloc.dart';

import '../../util/ui/search_product_bar/model/search_product_model.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc(this._restAPI, this.wishlistBloc)
      : super(ProductDetailsState()) {
    on<GetProductDetailsEvent>(_getProductDetailsEvent);
    on<UpdateRatingEvent>(_updateRating);
    on<ClickAddReviewEvent>(_clickAddReviewEvent);
    on<ClickWishlistBtnEvent>(_wishListBtnClick);
    on<SelectSpecEvent>(_selectSpec);
    on<ClickSpecConfirmEvent>(_clickSpecConfirm);
    // on<ToggleFavoriteEvent>(_toggleFavorite);
  }

  final RestAPI _restAPI;
  WishlistBloc wishlistBloc;
  BuildContext? context;

  final TextEditingController ratingTextController = TextEditingController();
  final GlobalKey<FormState> ratingForm = GlobalKey();

  void _clickSpecConfirm(ClickSpecConfirmEvent event, Emitter emit) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(event.context);
    if (state.selectedSpec.length != state.specifications.length) {
      showSnackBar(
        message: "Please select other specifications!",
        title: "Select Specification",
        context: event.context,
        titleColor: Colors.black,
        messageColor: Colors.black,
        backgroundColor: Colors.amber,
      );
    } else {
      if (userBloc.state.user == null) {
        RouterService.of(event.context).push(RouterPath.I.login.fullPath);
      } else {
        final prices = state.productDetails!.price
            .where((element) => element.id == state.selectedPriceId);
        if (prices.isNotEmpty) {
          final price = prices.first;
          final Map<String, dynamic> jsonData = price.toJson();
          jsonData["product_specification"] =
              price.productSpecifications.map((e) {
            final jsonSpec = e.toJson();
            jsonSpec["specification_type"] = e.specificationType.toJson();

            jsonSpec["specification_value"] = e.specificationValue.toJson();
            return jsonSpec;
          }).toList();
          jsonData["product_image"] =
              price.productImage.map((e) => e.toJson()).toList();
          BlocProvider.of<CartBloc>(event.context).add(UpdateUserCartEvent(
            context: event.context,
            data: {
              "quantity": 1,
              "image":
                  state.featureImagePath + (state.productDetails!.image ?? ""),
              "name_en": state.productDetails!.enName,
              "name_mm": state.productDetails!.mmName,
              "product_price": jsonData,
            },
          ));
        }
        RouterService.of(event.context).pop();
        if (event.buyNow) {
          RouterService.of(event.context)
              .push(RouterPath.I.cartScreen.fullPath);
        }
      }
    }
  }

  void _selectSpec(SelectSpecEvent event, Emitter emit) {
    if (state.selectedPriceId == null) {
      emit(
        state.copyWith(
          selectedPriceId: event.spec.productPrice?.first,
          selectedSpec: [event.spec],
        ),
      );
    } else {
      final bool equalPriceId =
          (event.spec.productPrice ?? []).contains(state.selectedPriceId);

      if (equalPriceId) {
        final List<SpecificationvalueModel> filterData = state.selectedSpec
            .where((element) =>
                element.specificationTypeId != event.spec.specificationTypeId)
            .toList();
        emit(state.copyWith(selectedSpec: [...filterData, event.spec]));
      } else {
        final List<SpecificationvalueModel> filterData = state.selectedSpec
            .where(
              (element) => element.productPrice!
                  .contains(event.spec.productPrice?.first),
            )
            .toList();
        emit(
          state.copyWith(
            selectedPriceId: event.spec.productPrice?.first,
            selectedSpec: [...filterData, event.spec],
          ),
        );
        //Remove That Doesn't Contain New Price Id & update new price id
      }
    }
  }

  // Future<void> _toggleFavorite(ToggleFavoriteEvent event, Emitter emit) async {
  //   emit(state.copyWith(isFavorite: event.isFavorite));
  // }

  Future<void> _wishListBtnClick(
      ClickWishlistBtnEvent event, Emitter emit) async {
    emit(state.copyWith(wishlistApiStatus: ApiStatus.processing));
    print("this is favorite before click ====> ${state.isFavorite}");
    bool isFavorite = !state.isFavorite;
    final resData =
        await _addRemoveWishList(productId: state.productDetails!.id);
    emit(state.copyWith(wishlistApiStatus: ApiStatus.completed));
    BlocProvider.of<UserBloc>(event.context).add(
      RemoveOrAddWishlistEvent(
          context: event.context, id: state.productDetails!.id),
    );

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
    emit(state.copyWith(isFavorite: isFavorite));
    print("this is favorite after click====> ${state.isFavorite}");
  }

  bool checkInWishList(List<SearchProductModel> list, int productId) {
    bool isToggleFavorite = list.any(
      (element) => element.id == productId,
    );
    return isToggleFavorite;
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
                  BlocProvider.of<UserBloc>(event.context).state.user!.id ?? 0,
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

  Future<void> _getProductDetailsEvent(
      GetProductDetailsEvent event, Emitter emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.processing));
    final resData = await _getProductDetails(slug: event.slug);

    if (resData != null) {
      final jsonReview = resData["reviews"] as List;
      final jsonSpecs = resData["productSpecification"] as List;

      List<SelectSpecificationModel> selectSpecs =
          jsonSpecs.map((e) => SelectSpecificationModel.fromJson(e)).toList();

      final List<ReviewModel> data =
          jsonReview.map((e) => ReviewModel.fromJson(e)).toList();

      final product = ProductDetailsModel.fromJson(resData["product"]);

      print("this is product specifications data ==> ${product.enDesc}");

      //! When Backend Response Fix , Need To Fix This -> :)
      selectSpecs = selectSpecs.map((specType) {
        final specs = specType.specificationValues.map(
          (spec) {
            for (var price in product.price) {
              final priceData = price.productSpecifications.where((priceSpec) =>
                  priceSpec.specificationTypeId == spec.specificationTypeId &&
                  priceSpec.specificationValueId == spec.id);
              if (priceData.isNotEmpty) {
                spec = spec.copyWith(
                  productPrice: [
                    ...spec.productPrice ?? [],
                    priceData.first.productPriceId,
                  ],
                );
              }
            }
            return spec;
          },
        ).toList();
        specType = specType.copyWith(specificationValues: specs);
        return specType;
      }).toList();

      print(
          " wish list state wish list data :  ${wishlistBloc.state.wishListData}");
      print("event slug ===> ${event.slug}");
      final isFavorite = wishlistBloc.state.favoritesSlug?.contains(event.slug);
      print(" wish list state product fav :  $isFavorite");
      emit(
        state.copyWith(
          isFavorite: isFavorite,
          apiStatus: ApiStatus.completed,
          productImagepath: resData["product_image_path"],
          disImagePath: resData["dis_image_path"],
          featureImagePath: resData["product_feature_image_path"],
          specifications: selectSpecs,
          productDetails: () => product,
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

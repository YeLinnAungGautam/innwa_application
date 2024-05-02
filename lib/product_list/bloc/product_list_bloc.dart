import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/product_list/model/filter_model.dart';
import 'package:innwa_mobile_dev/product_list/widgets/filter_bottom_sheetui.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc(this._restAPI) : super(ProductListState()) {
    on<FilterProductEvent>(_filterProductEvent);
    on<GetShopEvent>(_getShopEvent);
    on<ShowFilterBottomsheetEvent>(_showFilterBottomsheet);
    on<UpdateSelectedTitleEvent>(_updateSelectedTitle);
    on<UpdateSelectedCategoryTabEvent>(_updateSelectedCategoryTab);
    on<UpdateSelectedBrandsTabEvent>(_updateSelectedBrandTab);
    on<UpdateSelectedSpecificationsTabEvent>(_updateSelectedSpecTab);
    on<UpdateFilterSelectedCategoryEvent>(_updateFilterSelectedCategory);
    on<UpdateFilterSelectedBrandEvent>(_updateFilterSelectedBrand);
    on<UpdateFilterSelectedSpecEvent>(_updateFilterSelectedSpec);
    on<ClickApplyBtnEvent>(_clickApplyBtn);
    on<ClickClearBtnEvent>(_clickClearBtn);
    on<SetUsedToSelectedEvent>(_setUsedToSlected);
    on<ClearNextPageUrlEvent>(_clearNextpageUrl);
  }

  final RestAPI _restAPI;

  void _clearNextpageUrl(ClearNextPageUrlEvent event, Emitter emit) async {
    emit(state.clearNextPageUrl());
  }

  final PagingController<int, SearchProductModel>
      filterProductPagingController = PagingController(firstPageKey: 1);
  final List<Map> expansionData = [
    {
      "en": "Categories",
      "mm": "အမျိုးအစားများ",
    },
    {
      "en": "Brands",
      "mm": "အမှတ်တံဆိပ်များ",
    },
    {
      "en": "Specifications",
      "mm": "သတ်မှတ်ချက်များ",
    },
  ];

  void _setUsedToSlected(SetUsedToSelectedEvent event, Emitter emit) async {
    emit(state.copyWith(
      filterSelectedBrand: state.filterUsedBrand,
      filterSelectedCategory: state.filterUsedCategory,
      filterSelectedSpec: state.filterUsedSpec,
    ));
  }

  void _clickApplyBtn(ClickApplyBtnEvent event, Emitter emit) {
    emit(state.copyWith(
      filterUsedBrand: state.filterSelectedBrand,
      filterUsedCategory: state.filterSelectedCategory,
      filterUsedSpec: state.filterSelectedSpec,
    ));
    RouterService.of(event.context).pop();
  }

  void _clickClearBtn(ClickClearBtnEvent event, Emitter emit) {
    emit(state.copyWith(
      filterUsedBrand: [],
      filterUsedCategory: [],
      filterUsedSpec: [],
    ));
    RouterService.of(event.context).pop();
  }

  void _updateFilterSelectedBrand(
    UpdateFilterSelectedBrandEvent event,
    Emitter emit,
  ) {
    final checkIsHave = state.filterSelectedBrand
        .where((element) => element == event.slectedId);
    if (checkIsHave.isEmpty) {
      emit(
        state.copyWith(
          filterSelectedBrand: [...state.filterSelectedBrand, event.slectedId],
        ),
      );
    } else {
      emit(
        state.copyWith(
          filterSelectedBrand: [
            ...state.filterSelectedBrand,
          ]..remove(event.slectedId),
        ),
      );
    }
  }

  void _updateFilterSelectedSpec(
    UpdateFilterSelectedSpecEvent event,
    Emitter emit,
  ) {
    final checkIsHave =
        state.filterSelectedSpec.where((element) => element == event.slectedId);
    debugPrint(
        "-----------Hello---------------------${event.slectedId}--------------------------------");
    if (checkIsHave.isEmpty) {
      emit(
        state.copyWith(
          filterSelectedSpec: [...state.filterSelectedSpec, event.slectedId],
        ),
      );
    } else {
      emit(
        state.copyWith(
          filterSelectedSpec: [
            ...state.filterSelectedSpec,
          ]..remove(event.slectedId),
        ),
      );
    }
  }

  void _updateFilterSelectedCategory(
    UpdateFilterSelectedCategoryEvent event,
    Emitter emit,
  ) {
    final checkIsHave = state.filterSelectedCategory
        .where((element) => element == event.slectedId);
    if (checkIsHave.isEmpty) {
      emit(
        state.copyWith(
          filterSelectedCategory: [
            ...state.filterSelectedCategory,
            event.slectedId
          ],
        ),
      );
    } else {
      emit(
        state.copyWith(
          filterSelectedCategory: [
            ...state.filterSelectedCategory,
          ]..remove(event.slectedId),
        ),
      );
    }
  }

  void _updateSelectedBrandTab(
      UpdateSelectedBrandsTabEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        selectedBrandsTab: event.data,
      ),
    );
  }

  void _updateSelectedSpecTab(
      UpdateSelectedSpecificationsTabEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        selectedSpecificationsTab: event.data,
      ),
    );
  }

  void _updateSelectedCategoryTab(
      UpdateSelectedCategoryTabEvent event, Emitter emit) async {
    emit(state.copyWith(
      selectedCategoryTab: event.data,
    ));
  }

  void _updateSelectedTitle(UpdateSelectedTitleEvent event, Emitter emit) {
    emit(state.copyWith(selectedTitle: event.data));
  }

  Future<void> _showFilterBottomsheet(
    ShowFilterBottomsheetEvent event,
    Emitter emit,
  ) async {
    showModalBottomSheet(
      context: event.context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<ProductListBloc>(event.context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: const FilterBottomSheetUi(),
            ),
          ),
        );
      },
    ).then((value) {
      add(SetUsedToSelectedEvent(context: event.context));
      filterProductPagingController.refresh();
    });
  }

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
      path: ApiKey.productFilter + params!,
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
    final List<int> extraId = [];

    if (state.filterData != null) {
      for (var category in state.filterData!.categories) {
        final List<int> tempChildCategory = [];
        for (var childCategory in category.childCategories) {
          if (state.filterSelectedCategory.contains(childCategory.id)) {
            tempChildCategory.add(childCategory.id);
          }
        }
        if (category.childCategories.length == tempChildCategory.length &&
            tempChildCategory.isNotEmpty) {
          extraId.add(category.id);
        }
      }
    }

    final resData = await _searchProduct(
      params: state.nextPageUrl != null
          ? "?page=${Uri.parse(state.nextPageUrl!).queryParameters["page"]}"
          : "?page=1",
      data: {
        "category_id": [...state.filterUsedCategory, ...extraId],
        "brand_id": state.filterUsedBrand,
        "spec_value_id": state.filterUsedSpec,
      },
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

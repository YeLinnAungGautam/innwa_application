import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/product_list/bloc/product_list_bloc.dart';
import 'package:innwa_mobile_dev/_application/product_list/widgets/expansion_item.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class FilterBottomSheetUi extends StatelessWidget {
  const FilterBottomSheetUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        final ProductListBloc productListBloc = BlocProvider.of(context);
        return Scaffold(
          bottomSheet: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    productListBloc.add(ClickClearBtnEvent(context: context));
                  },
                  child: SizedBox(
                    height: 50,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RobotoText(
                          fontSize: 18.0,
                          fontColor: Colors.red,
                          text: "Clear Filter",
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    productListBloc.add(ClickApplyBtnEvent(context: context));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: bottomSheetColor2,
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RobotoText(
                          fontSize: 18.0,
                          fontColor: Colors.white,
                          text: "Apply",
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: false,
                leading: const SizedBox(),
                surfaceTintColor: Colors.transparent,
                leadingWidth: 0,
                title: RobotoText(
                  fontSize: 20.0,
                  fontColor: Colors.black,
                  text: "Filter By",
                  fontWeight: FontWeight.normal,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => RouterService.of(context).pop(),
                      child: const Icon(
                        Icons.close,
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
              SliverList.list(
                children: [
                  Wrap(
                    children: [
                      ExpansionTile(
                        collapsedShape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: RobotoText(
                          fontSize: 17.0,
                          fontColor: Colors.black,
                          text: productListBloc.expansionData[0],
                        ),
                        onExpansionChanged: (value) {
                          productListBloc.add(UpdateSelectedTitleEvent(
                            context: context,
                            data: 0,
                          ));

                          // setState(() {
                          // //   isExpandedList[index] = value;
                          // // });
                        },
                        initiallyExpanded: state.selectedTitle == 0,
                        children: [
                          ...state.filterData!.categories.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Wrap(
                                children: [
                                  ExpansionTile(
                                    collapsedShape:
                                        const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    title: RobotoText(
                                      fontSize: 17.0,
                                      fontColor: Colors.black,
                                      text: e.enName,
                                    ),
                                    onExpansionChanged: (value) {
                                      productListBloc
                                          .add(UpdateSelectedCategoryTabEvent(
                                        context: context,
                                        data: e.id,
                                      ));
                                    },
                                    initiallyExpanded:
                                        state.selectedCategoryTab == e.id,
                                    children: [
                                      ...e.childCategories.map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            productListBloc.add(
                                                UpdateFilterSelectedCategoryEvent(
                                                    context: context,
                                                    slectedId: e.id));
                                          },
                                          child: AbsorbPointer(
                                            child: ExpansionItem(
                                              label: e.enName,
                                              isActive: state
                                                  .filterSelectedCategory
                                                  .contains(e.id),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.blueAccent.withOpacity(0.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[300],
                      )
                    ],
                  ),
                  Wrap(
                    children: [
                      ExpansionTile(
                        collapsedShape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: RobotoText(
                          fontSize: 17.0,
                          fontColor: Colors.black,
                          text: productListBloc.expansionData[1],
                        ),
                        onExpansionChanged: (value) {
                          productListBloc.add(UpdateSelectedTitleEvent(
                            context: context,
                            data: 1,
                          ));

                          // setState(() {
                          // //   isExpandedList[index] = value;
                          // // });
                        },
                        initiallyExpanded: state.selectedTitle == 1,
                        children: [
                          ...state.filterData!.brands.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Wrap(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      productListBloc.add(
                                        UpdateFilterSelectedBrandEvent(
                                          context: context,
                                          slectedId: e.id,
                                        ),
                                      );
                                    },
                                    child: AbsorbPointer(
                                      child: ExpansionItem(
                                        label: e.enName,
                                        isActive: state.filterSelectedBrand
                                            .contains(e.id),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[300],
                      )
                    ],
                  ),
                  Wrap(
                    children: [
                      ExpansionTile(
                        collapsedShape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: RobotoText(
                          fontSize: 17.0,
                          fontColor: Colors.black,
                          text: productListBloc.expansionData[2],
                        ),
                        onExpansionChanged: (value) {
                          productListBloc.add(UpdateSelectedTitleEvent(
                            context: context,
                            data: 2,
                          ));

                          // setState(() {
                          // //   isExpandedList[index] = value;
                          // // });
                        },
                        initiallyExpanded: state.selectedTitle == 2,
                        children: [
                          ...state.filterData!.specTypes.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Wrap(
                                children: [
                                  ExpansionTile(
                                    collapsedShape:
                                        const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    title: RobotoText(
                                      fontSize: 17.0,
                                      fontColor: Colors.black,
                                      text: e.enName,
                                    ),
                                    onExpansionChanged: (value) {
                                      productListBloc.add(
                                          UpdateSelectedSpecificationsTabEvent(
                                        context: context,
                                        data: e.id,
                                      ));
                                    },
                                    initiallyExpanded:
                                        state.selectedCategoryTab == e.id,
                                    children: [
                                      ...e.specificationValue.map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            productListBloc.add(
                                              UpdateFilterSelectedSpecEvent(
                                                context: context,
                                                slectedId: e.id,
                                              ),
                                            );
                                          },
                                          child: AbsorbPointer(
                                            child: ExpansionItem(
                                              label: e.value,
                                              colorCode: e.colorCode,
                                              isActive: state.filterSelectedSpec
                                                  .contains(e.id),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.blueAccent.withOpacity(0.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[300],
                      )
                    ],
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: 120.vertical,
              ),
            ],
          ),
        );
      },
    );
  }
}

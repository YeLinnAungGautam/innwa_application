import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/component/select_colors.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/component/select_storage.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class SpecSelectUi extends StatelessWidget {
  const SpecSelectUi({super.key, required this.buyNow});
  final bool buyNow;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10.0))),
          child: Scaffold(
            bottomSheet: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<ProductDetailsBloc>(context).add(
                      ClickSpecConfirmEvent(context: context, buyNow: buyNow));
                },
                child: Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bottomSheetColor2,
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocalizationWidget(
                          en: "Confirm",
                          mm: "အတည်ပြုပါ",
                          child: (val) {
                            return RobotoText(
                              fontSize: 18.0,
                              fontColor: Colors.white,
                              text: val,
                              fontWeight: FontWeight.bold,
                            );
                          })
                    ],
                  )),
                ),
              ),
            ),
            appBar: AppBar(
              toolbarHeight: 75,
              leading: const SizedBox(),
              leadingWidth: 0,
              foregroundColor: Colors.white,
              title: Column(
                children: [
                  const Icon(
                    Icons.minimize_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: LocalizationWidget(
                            en: state.productDetails?.enName,
                            mm: state.productDetails?.mmName,
                            child: (val) {
                              return RobotoText(
                                maxLine: 1,
                                fontSize: 20.0,
                                fontColor: Colors.black,
                                text: val,
                                fontWeight: FontWeight.w700,
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: CustomScrollView(
              slivers: [
                ...state.specifications.map(
                  (spec) => SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: LocalizationWidget(
                                      en: "Select ${spec.nameEn}",
                                      mm: "${spec.naemMm} ရွေးပါ",
                                      child: (val) {
                                        return RobotoText(
                                          fontSize: 15.0,
                                          fontColor: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          text: "$val : ",
                                        );
                                      },
                                    ),
                                  ),
                                  if (spec.specificationValues.first
                                          .colorCode ==
                                      null)
                                    SelectStorage(
                                      data: spec.specificationValues,
                                      onClick: (data) {
                                        BlocProvider.of<ProductDetailsBloc>(
                                                context)
                                            .add(SelectSpecEvent(
                                                context: context, spec: data));
                                      },
                                    ),
                                  if (spec.specificationValues.first
                                          .colorCode !=
                                      null)
                                    SelectColors(
                                      colors: spec.specificationValues,
                                      onClick: (data) {
                                        BlocProvider.of<ProductDetailsBloc>(
                                                context)
                                            .add(SelectSpecEvent(
                                                context: context, spec: data));
                                      },
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: 100.vertical,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

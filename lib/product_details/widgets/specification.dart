import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text_padding.dart';

class Specification extends StatelessWidget {
  const Specification({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10.0))),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 0,
              leading: const SizedBox(),
              surfaceTintColor: Colors.white,
              toolbarHeight: 75,
              title: Column(
                children: [
                  const Icon(
                    Icons.minimize_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                  10.vertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
                        child: LocalizationWidget(
                            en: "Specifications",
                            mm: "သတ်မှတ်ချက်များ",
                            child: (val) {
                              return RobotoText(
                                fontSize: 16.0,
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
              centerTitle: true,
            ),
            body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        15.vertical,
                        ...state.specifications.map((spec) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: LocalizationWidget(
                                    en: spec.nameEn,
                                    mm: spec.naemMm,
                                    child: (val) {
                                      return RobotoText(
                                        fontSize: 15.0,
                                        fontColor: Colors.black,
                                        text: val,
                                        fontWeight: FontWeight.bold,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  child: RobotoTextPadding(
                                    padding: 4,
                                    fontSize: 15.0,
                                    maxLine: 4,
                                    fontColor: Colors.black,
                                    text: spec.specificationValues
                                        .map((e) => e.value)
                                        .join(","),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

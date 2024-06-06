import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LocalizationWidget(
                          en: state.productDetails!.enDesc,
                          mm: state.productDetails!.mmDesc,
                          child: (desc) {
                            return HtmlWidget(
                              desc,
                            );
                          },
                        ),
                      ),
                      10.vertical,
                    ],
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

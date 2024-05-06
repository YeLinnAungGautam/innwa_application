import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/discount_banner/discount_banner.dart';
import 'package:innwa_mobile_dev/shared/price_tag/price_tag.dart';

class ProductPriceSection extends StatelessWidget {
  const ProductPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              ...state.productDetails!.price.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (p.disPrice != null)
                                LocalizationWidget(
                                  en: "Discount",
                                  mm: "လျှော့စျေး",
                                  child: (val) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.amber.shade800,
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(6, 3),
                                              spreadRadius: -4,
                                              blurRadius: 10,
                                              color: Color.fromRGBO(
                                                  229, 229, 229, 1),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: DiscountBanner(
                                          text:
                                              "$val - ${formatNumber(dbNumber: double.parse(p.disPrice!))} MMK"),
                                    );
                                  },
                                ),
                              if (p.cashback != null) 10.horizontal,
                              if (p.cashback != null)
                                LocalizationWidget(
                                  en: "Cashback",
                                  mm: "ပြန်အမ်းငွေ",
                                  child: (val) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF4C53A5),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(6, 3),
                                              spreadRadius: -4,
                                              blurRadius: 10,
                                              color: Color.fromRGBO(
                                                  229, 229, 229, 1),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: DiscountBanner(
                                          text:
                                              "$val - ${formatNumber(dbNumber: double.parse(p.cashback!))} MMK"),
                                    );
                                  },
                                ),
                            ],
                          ),
                          if (p.gift != null) 10.vertical,
                          if (p.gift != null)
                            LocalizationWidget(
                              en: "Gift",
                              mm: "လက်ဆောင်",
                              child: (val) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(6, 3),
                                          spreadRadius: -4,
                                          blurRadius: 10,
                                          color:
                                              Color.fromRGBO(229, 229, 229, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: DiscountBanner(
                                    text: "$val - ${p.gift!}",
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 6.0, bottom: 5.0, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PriceTag(
                                  haveDiscount: p.disPrice != null,
                                  text: formatNumber(
                                      dbNumber: p.price.toDouble()),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                if (p.disPrice != null)
                                  PriceTag(
                                    fontSize: 15,
                                    text: formatNumber(
                                      dbNumber: p.price.toDouble() -
                                          double.parse(p.disPrice!) -
                                          double.parse(
                                            p.cashback ?? "0",
                                          ),
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                              ],
                            ),
                            PriceTag(
                              text: " MMK",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

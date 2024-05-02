import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/shared/add_to_card/add_to_card.dart';
import 'package:innwa_mobile_dev/shared/discount_banner/discount_banner.dart';
import 'package:innwa_mobile_dev/shared/price_tag/price_tag.dart';
import 'package:innwa_mobile_dev/shared/texts/product_title.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.imagePath,
    this.isRoot = false,
  });
  final ProductModel product;
  final String imagePath;
  final bool isRoot;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  debugPrint(
                      "-----------${!isRoot ? "${RouterPath.I.productDetails.fullPath}?slug=${product.slug}" : "/${RouterPath.I.productDetails.path}?slug=${product.slug}"}----------------------------------------------------");
                  RouterService.of(context).push(
                      !isRoot
                          ? "${RouterPath.I.productDetails.fullPath}?slug=${product.slug}"
                          : "${RouterPath.I.rootProductDetails.fullPath}?slug=${product.slug}",
                      redirect: false);
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: imagePath + product.image,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (product.price.disPrice != null)
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: DiscountBanner(
                                        text:
                                            "$val - ${formatNumber(dbNumber: double.parse(product.price.disPrice!))} MMK"),
                                  );
                                }),
                          if (product.price.cashback != null) 10.vertical,
                          if (product.price.cashback != null)
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: DiscountBanner(
                                        text:
                                            "$val - ${formatNumber(dbNumber: double.parse(product.price.cashback!))} MMK"),
                                  );
                                }),
                          if (product.price.gift != null) 10.vertical,
                          if (product.price.gift != null)
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
                                    text: "$val - ${product.price.gift!}",
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  RouterService.of(context).push(
                      "${RouterPath.I.productDetails.fullPath}?slug=${product.slug}",
                      redirect: false);
                },
                child: Column(
                  children: [
                    LocalizationWidget(
                      en: product.enName,
                      mm: product.mmName,
                      child: (val) {
                        return Container(
                          height: 46,
                          padding: const EdgeInsets.only(
                              bottom: 4, left: 8.0, top: 8.0),
                          alignment: Alignment.centerLeft,
                          child: ProductTitle(
                            text: val,
                          ),
                        );
                      },
                    ),
                    LocalizationWidget(
                        en: "Price",
                        mm: "စျေးနှုန်း",
                        child: (val) {
                          return Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                                left: 6.0, bottom: 5.0, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PriceTag(
                                    text: "$val : ",
                                  ),
                                  Column(
                                    children: [
                                      PriceTag(
                                        haveDiscount:
                                            product.price.disPrice != null,
                                        text: formatNumber(
                                            dbNumber: product.price.amount),
                                      ),
                                      if (product.price.disPrice != null)
                                        PriceTag(
                                          text: formatNumber(
                                              dbNumber: product.price.amount -
                                                  double.parse(
                                                      product.price.disPrice!) -
                                                  double.parse(
                                                      product.price.cashback ??
                                                          "0")),
                                        ),
                                    ],
                                  ),
                                  Flexible(
                                    child: PriceTag(
                                      text: " MMK",
                                    ),
                                  ),
                                ]),
                          );
                        }),
                  ],
                ),
              ),
              ViewMoreBtn(
                width: 180,
                height: 30,
                onClick: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (!isRoot) {
                    RouterService.of(context).push(
                        "${RouterPath.I.productDetails.fullPath}?slug=${product.slug}",
                        redirect: false);
                  } else {
                    RouterService.of(context).push(
                        "${RouterPath.I.rootProductDetails.fullPath}?slug=${product.slug}",
                        redirect: false);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

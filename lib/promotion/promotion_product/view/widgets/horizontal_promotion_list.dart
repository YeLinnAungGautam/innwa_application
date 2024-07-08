import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/constant/api_constant.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/view/widgets/view_more_promotion.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

import '../../response/vos/data_vo/data_vo.dart';

class HorizontalPromotionList extends StatelessWidget {
  const HorizontalPromotionList(
      {required this.data, super.key, required this.path});

  final Data? data;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        20.vertical,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.76,
                child: LocalizationWidget(
                    en: data?.nameEn,
                    mm: data?.nameMm,
                    child: (val) {
                      return RobotoText(
                        fontSize: 17,
                        fontColor: null,
                        fontWeight: FontWeight.bold,
                        text: val,
                        maxLine: 3,
                      );
                    }),
              ),
              GestureDetector(
                onTap: () async {
                  await RouterService.of(context).push(
                      "${RouterPath.I.promotionsDertails.fullPath}?slug=${data?.slug}");
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) =>
                  //       PromotionsDetailsScreen(promotionData: data),
                  // ));
                },
                child: const Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        20.vertical,
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizedBox(
            height: 300, // Set a reasonable height for the list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (data?.promotionProduct?.length ?? 0) > 4
                  ? 5
                  : data?.promotionProduct?.length,
              itemBuilder: (context, index) {
                final productPrice =
                    data?.promotionProduct?[index].productPrice;
                final product =
                    data?.promotionProduct?[index].productPrice?.product;

                if (index == 4) {
                  return ViewMorePromotion(
                    onTap: () async {
                      await RouterService.of(context).push(
                          "${RouterPath.I.promotionsDertails.fullPath}?slug=${data?.slug}");
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) =>
                      //       PromotionsDetailsScreen(promotionData: data),
                      // ));
                    },
                  );
                }
                return ProductCard(
                  imagePath: kBaseUrl + path,
                  isPromotionProduct: true,
                  productEnName: product?.nameEn,
                  productMmName: product?.nameMm,
                  productImageUrl: product?.featureImage,
                  productSlug: product?.slug,
                  productPrice: productPrice?.priceMmk,
                  productDisPrice: productPrice?.disPrice,
                  productCashBack: productPrice?.cashback,
                  gift: productPrice?.gift,
                );
              },
            ),
          ),
        ),
        20.vertical,
        const Divider(),
        20.vertical,
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/model/promotion_list_model.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/view/widgets/view_more_promotion.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class HorizontalPromotionList extends StatelessWidget {
  const HorizontalPromotionList({required this.data, super.key});
  final PromotionListModel data;

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
                    en: data.enName,
                    mm: data.mmName,
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
                      "${RouterPath.I.promotionsDertails.fullPath}?slug=test");
                },
                child: const Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: Colors.black,
                  size: 25,
                ),
              )
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
              itemCount: 5,
              itemBuilder: (context, index) {
                return index < 4
                    ? ProductCard(
                        product: ProductModel.fromJson(const {
                          "id": 402,
                          "name_en": "Oppo A58 (6/128GB)",
                          "name_mm": "Oppo A58 (6/128GB)",
                          "feature_image":
                              '20240201114065125e6ab0cbdoppo-a58 (1).webp',
                          "slug": 'oppo-a58-6128gb-402',
                          "first_price": {
                            "product_price_id": 559,
                            "product_id": 402,
                            "dis_image": null,
                            "dis_start_date": '2024-02-01',
                            "dis_end_date": '2024-02-11',
                            "dis_price": '30000',
                            "cashback": null,
                            "gift": null,
                            "price_mmk": 629900,
                          },
                        }),
                        imagePath:
                            "https://shop.innwa.com.mm/storage/product/feature_image/",
                      )
                    : const ViewMorePromotion();
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

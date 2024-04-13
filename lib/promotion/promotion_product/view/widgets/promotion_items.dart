import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/model/promotion_list_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class PromotionItems extends StatelessWidget {
  const PromotionItems(
      {required this.imagePrefix, required this.promotion, super.key});
  final String imagePrefix;
  final PromotionListModel promotion;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        RouterService.of(context).push(
            "${RouterPath.I.promotionsDertails.fullPath}?slug=${promotion.slug}");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 3),
                spreadRadius: 0,
                blurRadius: 2,
                color: Color.fromRGBO(200, 199, 199, 1),
              )
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 180,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imagePrefix + promotion.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalizationWidget(
                      en: promotion.enName,
                      mm: promotion.mmName,
                      child: (val) {
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: RobotoText(
                                  fontSize: 15.0,
                                  fontColor: Colors.black,
                                  text: val,
                                  maxLine: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                  8.vertical,
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  //       child: RobotoText(
                  //         fontSize: 15.0,
                  //         fontColor: Colors.black,
                  //         text: DateFormat('dd/MM/yyyy').format(
                  //           DateTime.parse(promotion.publishedAt),
                  //         ),
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  LocalizationWidget(
                      en: promotion.enDesc,
                      mm: promotion.mmDesc,
                      child: (val) {
                        return Row(
                          children: [
                            Builder(builder: (context) {
                              final document = parse(val);
                              final String parsedString =
                                  parse(document.body!.text)
                                      .documentElement!
                                      .text;
                              return SizedBox(
                                width: MediaQuery.of(context).size.width <= 600
                                    ? 160
                                    : 400,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 8.0, bottom: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    margin: const EdgeInsets.only(bottom: 10.0),
                                    child: RobotoText(
                                      fontSize: 14,
                                      fontColor: Colors.grey,
                                      text: parsedString,
                                      maxLine: 3,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

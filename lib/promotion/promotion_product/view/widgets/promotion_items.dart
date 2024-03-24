import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/model/promotion_list_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:intl/intl.dart';

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
              ]),
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
                      imageUrl: imagePrefix + promotion.image),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: RobotoText(
                          fontSize: 15.0,
                          fontColor: Colors.black,
                          text: promotion.mmName ?? promotion.enName,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  8.vertical,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: RobotoText(
                          fontSize: 15.0,
                          fontColor: Colors.black,
                          text: DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(promotion.publishedAt),
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  if (promotion.enDesc != null || promotion.mmDesc != null)
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width <= 600
                              ? 160
                              : 400,
                          child: Html(
                            data: promotion.enDesc ?? promotion.mmDesc,
                          ),
                        ),
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/article/article_list/models/article_list_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ArticleItems extends StatelessWidget {
  const ArticleItems(
      {required this.imagePrefix, required this.article, super.key});
  final String imagePrefix;
  final ArticleListModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        RouterService.of(context).push(
            "${RouterPath.I.articleDetails.fullPath}?slug=${article.slug}");
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
          height: 200,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imagePrefix + article.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalizationWidget(
                      en: article.enName,
                      mm: article.mmName,
                      child: (val) {
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.black,
                                text: val,
                                fontWeight: FontWeight.w600,
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
                  //           DateTime.parse(article.publisedAt),
                  //         ),
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  Row(
                    children: [
                      LocalizationWidget(
                          en: article.enDesc,
                          mm: article.mmDesc,
                          child: (val) {
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
                  ),
                  const Expanded(child: SizedBox()),
                  LocalizationWidget(
                    en: "View More",
                    mm: "ပိုမိုကြည့်ရှုရန်",
                    child: (val) {
                      return Container(
                        height: 35,
                        margin: const EdgeInsets.only(left: 5, bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(),
                          onPressed: () {
                            RouterService.of(context).push(
                                "${RouterPath.I.articleDetails.fullPath}?slug=${article.slug}");
                          },
                          child: Text(val),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

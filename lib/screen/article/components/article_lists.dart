import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/article/article_detail.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ArticleLists extends StatelessWidget {
  const ArticleLists({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ArticleDetail())),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const[
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
              Container(
                width: 180,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            "https://innwa.com.mm/images/products/smartphone/huawei/646b285f9fa4a/646b285f9fa4ahuawei-mateX3.png"))),
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
                          text: "Headidng Title",
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width <= 600
                            ? 160
                            : 400,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 8.0, bottom: 8.0),
                          child: RobotoText(
                            fontSize: 12.0,
                            fontColor: Colors.grey,
                            fontWeight: FontWeight.w500,
                            text:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem",
                            maxLine: 3,
                          ),
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

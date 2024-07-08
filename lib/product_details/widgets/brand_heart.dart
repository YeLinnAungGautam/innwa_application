import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';


class ProductRow extends StatelessWidget {
  Color bg;
  Color textColor;
  String text;
  String textTwo;
  bool isIcon;
  bool isDiscount;
  String price;
  double fontSize;
  FontWeight fontWeight;

  ProductRow(
      {super.key,
      required this.textTwo,
      required this.fontSize,
      required this.isDiscount,
      required this.fontWeight,
      required this.bg,
      required this.textColor,
      required this.text,
      required this.isIcon,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: bg),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoText(
                      fontSize: fontSize,
                      fontColor: textColor,
                      text: text,
                      fontWeight: fontWeight),
                ),
              ),

              isDiscount ? 

              Padding(
                padding: const EdgeInsets.only(left:4.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: bg),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RobotoText(
                        fontSize: fontSize,
                        fontColor: textColor,
                        text: textTwo,
                        fontWeight: fontWeight),
                  ),
                ),
              )
              :
              const SizedBox(),
            ],
          ),
          isIcon
              ?  Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.favorite),
                ),
              )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoText(
                      fontSize: fontSize,
                      fontColor: textColor,
                      text: price,
                      fontWeight: fontWeight),
                ),
        ],
      ),
    );
  }
}

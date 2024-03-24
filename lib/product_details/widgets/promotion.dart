import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:intl/intl.dart';

class ProductPromotion extends StatelessWidget {
  const ProductPromotion({required this.price, super.key});
  final ProductDetailsPriceModel price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Badge(
              label: Text(
                price.stockStatus,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            5.vertical,
            if (price.disStartDate != null && price.disendDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RobotoText(
                    fontSize: 15.0,
                    fontColor: Colors.black,
                    text: "*Discount",
                    fontWeight: FontWeight.w600,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: RobotoText(
                  //       fontSize: 13.5,
                  //       fontColor: Colors.black,
                  //       text: "New Year Promotion"),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: RobotoText(
                      fontSize: 13.5,
                      fontColor: Colors.black,
                      maxLine: 2,
                      text:
                          "From ${DateFormat('MMMM d, yyyy').format(DateTime.parse(price.disStartDate!))} - ${DateFormat('MMMM d, yyyy').format(DateTime.parse(price.disendDate!))} ",
                    ),
                  )
                ],
              ),
            if (price.disStartDate != null && price.disendDate != null)
              const Divider(
                color: dividerColor,
                height: 3,
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (price.disPrice != null)
                        SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.w600,
                                text: "*Discount",
                              ),
                              RobotoText(
                                  fontSize: 13.0,
                                  fontColor: Colors.black,
                                  text:
                                      "${formatNumber(dbNumber: double.tryParse(price.disPrice!))} MMK")
                            ],
                          ),
                        ),
                      if (price.cashback != null)
                        SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RobotoText(
                                  fontSize: 15.0,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  text: "*Cash Back"),
                              RobotoText(
                                  fontSize: 13.0,
                                  fontColor: Colors.black,
                                  text:
                                      "${formatNumber(dbNumber: double.tryParse(price.cashback!))} MMK")
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (price.gift != null)
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RobotoText(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                fontColor: Colors.black,
                                text: "*Gifts"),
                            RobotoText(
                                fontSize: 13.0,
                                fontColor: Colors.black,
                                text: "${price.gift}")
                          ],
                        )
                      ],
                    )
                ],
              ),
            ),
            if ((price.disStartDate != null && price.disendDate != null) ||
                price.disPrice != null ||
                price.cashback != null ||
                price.gift != null)
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Divider(
                  color: dividerColor,
                  height: 3,
                ),
              )
          ],
        ),
      ),
    );
    // return Container(
    //   margin: EdgeInsets.all(8.0),
    //   width: MediaQuery.of(context).size.width,
    //   height: 100,
    //   decoration: BoxDecoration(
    //     color: backgroundColorLight,
    //     borderRadius: BorderRadius.circular(10.0)
    //   ),
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             RobotoText(fontSize: 15.0, fontColor: Colors.black87, text: "New Year Promotion",fontWeight: FontWeight.w500,),
    //             RobotoText(fontSize: 15.0, fontColor: Colors.black87, text: "From Jan 3 - Feb 10")
    //           ],
    //         ),

    //       ),

    //       Row(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(left:8.0),
    //             child: Icon(Icons.card_giftcard),
    //           ),
    //           Container(
    //             child: Padding(
    //               padding: const EdgeInsets.only(left:8.0),
    //               child: Gifts(),
    //             ),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}

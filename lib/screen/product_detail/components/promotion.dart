import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/gift.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class ProductPromotion extends StatelessWidget {
  const ProductPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RobotoText(
                  fontSize: 15.0,
                  fontColor: Colors.black,
                  text: "*Promotion",
                  fontWeight: FontWeight.w600,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: RobotoText(
                      fontSize: 13.5,
                      fontColor: Colors.black,
                      text: "New Year Promotion"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                  child: RobotoText(
                      fontSize: 13.5,
                      fontColor: Colors.black,
                      text: "From January 2 - February 2"),
                )
              ],
            ),
            Divider(
              color: dividerColor,
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RobotoText(
                                  fontSize: 15.0,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  text: "*Discount"),
                              RobotoText(
                                  fontSize: 13.0,
                                  fontColor: Colors.black,
                                  text: "10,000 MMK")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
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
                                  text: "10,000 MMK")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              text: "Powerbank, Keychaing, Cover")
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
             Padding(
               padding: const EdgeInsets.only(top:10.0),
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

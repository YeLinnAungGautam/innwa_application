import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/screen/cart/components/cart_item.dart';
import 'package:innwa_mobile_dev/screen/order/components/deli_info.dart';
import 'package:innwa_mobile_dev/screen/payment_options/other_payment.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/bottom_sheet.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 4",
      "Item 5"
    ];

    List<Widget> generateItems() {
      List<Widget> widgets = [];
      for (String item in items) {
        widgets.add(CartItem(
          isDelete: false,
          isItemContorl: false,
          isOrderHistory: false,
        ));
      }
      return widgets;
    }

    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: TopBar(
            needBackButton: true,
            needMenu: false,
            title: "Checkout",
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        child: RobotoText(
                            fontSize: 18.0,
                            fontColor: Colors.black,
                            text: "Delivery Info",
                            fontWeight: FontWeight.bold),
                      ),
                      DeliInfo(
                        leftText: "Name",
                        rightText: "Ko Kyaw Kyaw",
                        isLongText: false,
                      ),
                      DeliInfo(
                          leftText: "Phone",
                          rightText: "091234567789",
                          isLongText: false),

                      DeliInfo(
                          leftText: "Email",
                          rightText: "sample1234@gmail.com",
                          isLongText: false),
                      DeliInfo(
                          leftText: "Address",
                          rightText:
                              "No. 154,Seikkanthar Road , Kamaryut Township, Yangon, Yangon Region",
                          isLongText: true),

                      DeliInfo(leftText: "Note", rightText: "G&G ဆိုင်နား", isLongText: false),
                      
                     
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Divider(
                          color: dividerColor,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: RobotoText(
                            fontSize: 18.0,
                            fontColor: Colors.black,
                            text: "Order Summary",
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.grey[700],
                                text: "Sub Total"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.grey[700],
                                text: "100,000 MMK"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.grey[700],
                                text: "Delivery Fee"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.grey[700],
                                text: "5,000MMK"),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: dividerColor,
                          height: 4,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.grey[700],
                                text: "Total"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.grey[700],
                                text: "5,000MMK"),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return CustomBottomSheet(
                                          text: "Enter Promo Code",
                                          isPromo: true);
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 10, bottom: 10),
                                child: RobotoText(
                                    fontSize: 16.0,
                                    fontColor: Colors.blue,
                                    text: "Enter Promo Code"),
                              )),
                        ],
                      ),

                      Column(
                        children: generateItems(),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.height / 3,
                      //   decoration: const BoxDecoration(),
                      //   child: ListView.builder(
                      //     itemCount: 10,
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       return CartItem(
                      //         isDelete: false,
                      //         isItemContorl: true,
                      //         isOrderHistory: false,
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherPayment()),
                        )
                      },
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          'Order',
                          style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

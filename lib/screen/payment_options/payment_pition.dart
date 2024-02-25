import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/payment_options/other_payment.dart';

import 'package:innwa_mobile_dev/shared/avatar/avatar.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerWidget(onDrawerTap: () {
        
      },),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Avatar(
                            image:
                                "https://cdn-icons-png.flaticon.com/512/6491/6491490.png",
                            width: 70.0,
                            height: 70.0),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RobotoText(
                              fontSize: 16.0,
                              fontColor: Colors.black,
                              text: "Cash On Delivery"),
                        ],
                      ),
                      // ItemCountrol(),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: ()=>Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OtherPayment()),
                              ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 125,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Avatar(
                              image:
                                  "https://cdn-icons-png.flaticon.com/512/671/671517.png",
                              width: 70.0,
                              height: 70.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RobotoText(
                                fontSize: 16.0,
                                fontColor: Colors.black,
                                text: "Others Payment"),
                          ],
                        ),
                        // ItemCountrol(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

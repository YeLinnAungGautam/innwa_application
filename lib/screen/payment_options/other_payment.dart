import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/credit_card/add_card.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/payment/payment_logo.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class OtherPayment extends StatelessWidget {
  const OtherPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          appBar: TopBar(
            needBackButton: true,
            needMenu: false,
            title: "Payments",
          ),
          drawer: CustomDrawerWidget(onDrawerTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
              currentFocus.unfocus();
            }
          }),
          backgroundColor: backgroundColorLight,
          body: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 8.0,top: 15.0),
                      child: RobotoText(
                          fontSize: 20,
                          fontColor: Colors.indigo,
                          fontWeight: FontWeight.w600,
                          text: "Please Choose Payment Options"),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      children: [
                        InkWell(
                          onTap: () => {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PaymentLogo(
                                    imagePath: 'assets/images/ayapay.png'),
                                Text(
                                  "AYA Pay",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCard(
                                      text: "MPU",
                                    )),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(58, 90, 158, 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                PaymentLogo(imagePath: 'assets/images/mpu.png'),
                                Text(
                                  "MPU",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCard(
                                      text: "VISA",
                                    )),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(28, 28, 114, 1),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                PaymentLogo(
                                    imagePath: 'assets/images/visa.jpg'),
                                Text(
                                  "VISA",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

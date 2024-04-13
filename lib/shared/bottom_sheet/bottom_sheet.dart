import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/component/select_colors.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/component/select_storage.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class CustomBottomSheet extends StatelessWidget {
  String text;
  bool isPromo;
  CustomBottomSheet({super.key, required this.text, required this.isPromo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10.0))),
      child: isPromo ? PromoBottomSheet(context) : ItemBottomSheet(context),
    );
  }

  Padding PromoBottomSheet(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        children: [
          const Center(
            child: Icon(
              Icons.minimize_rounded,
              color: Colors.black,
              size: 40,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, bottom: 10.0, left: 10),
                child: RobotoText(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    fontColor: Colors.black,
                    text: "Enter Promo Code"),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10),
                child: RobotoText(
                    fontSize: 15.0,
                    maxLine: 2,
                    fontColor: Colors.black,
                    text:
                        "If you have a Wolt promo code or gift card, enter it below to claim your benefits."),
              ),
            ],
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Promo Code",
                    labelStyle: const TextStyle(
                      color: kTextFieldColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black54)),
                  ),
                ),
              )),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              child: Center(
                  child: Text(
                'Apply',
                style: GoogleFonts.roboto(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Wrap ItemBottomSheet(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            const Icon(
              Icons.minimize_rounded,
              color: Colors.black,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RobotoText(
                      fontSize: 20.0,
                      fontColor: Colors.black,
                      text: text,
                      fontWeight: FontWeight.w700),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      RobotoText(
                          fontSize: 13.0,
                          fontColor: Colors.black,
                          text: "(4.3)")
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RobotoText(
                          fontSize: 15.0,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.w700,
                          text: "Storage : "),
                      SelectStorage(isColor: false)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RobotoText(
                          fontSize: 15.0,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.w700,
                          text: "Select Color : "),
                      SelectColors(
                        isColor: true,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  RouterService.of(context)
                      .push(RouterPath.I.cartScreen.fullPath);
                },
                child: Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bottomSheetColor2,
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RobotoText(
                        fontSize: 18.0,
                        fontColor: Colors.white,
                        text: "Confirm",
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  )),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

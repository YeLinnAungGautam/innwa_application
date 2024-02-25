import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/screen/cart/components/cart_heading.dart';
import 'package:innwa_mobile_dev/screen/cart/components/cart_lists.dart';
import 'package:innwa_mobile_dev/screen/cart/components/total_price.dart';
import 'package:innwa_mobile_dev/screen/shipping_address/shipping_address.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          appBar: TopBar(needBackButton: true,needMenu: false,title: "My Cart",),
          drawer: CustomDrawerWidget(onDrawerTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
                       
                      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                        currentFocus.unfocus();
                      }
          }),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CartLists(),
              const TotalPrice(),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2,color: Colors.indigo),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    'Back',
                    style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShippingAddress())),
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      'Check Out',
                      style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
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

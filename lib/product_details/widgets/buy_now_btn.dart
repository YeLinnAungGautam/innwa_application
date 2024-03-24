import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/bottom_sheet.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class BuyNow extends StatelessWidget {
  const BuyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                8,
              )),
              side: const BorderSide(color: primaryColor, width: 1.5),
              fixedSize: const Size(150, 50),
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return CustomBottomSheet(
                    text: "Lenovo Think Pad",
                    isPromo: false,
                  );
                },
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.shopping_cart_checkout_rounded, color: Colors.black),
                Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ],
            )),
      );
    });
  }
}

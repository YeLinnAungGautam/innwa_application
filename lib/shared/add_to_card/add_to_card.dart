import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/bottom_sheet.dart';

class AddToCard extends StatelessWidget {
  double width;
  double height;
  AddToCard({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return LocalizationWidget(
        en: "Add to Cart",
        mm: "ခြင်းထဲသို့ထည့်မည်",
        child: (val) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                side: const BorderSide(width: 1, color: Colors.grey),
                fixedSize: Size(width, height),
                backgroundColor: Colors.white, //<-- SEE HERE
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(
                      text: "Lenovo Think Pad",
                      isPromo: false,
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_sharp,
                    color: Colors.black,
                    size: 17.0,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(
                        val,
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

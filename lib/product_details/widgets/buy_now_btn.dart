import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/product_details/widgets/spec_select_ui.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class BuyNow extends StatelessWidget {
  const BuyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return LocalizationWidget(
        en: 'Buy Now',
        mm: "အခုဝယ်ပါ",
        child: (val) {
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
                    builder: (ctx) {
                      return BlocProvider.value(
                        value: BlocProvider.of<ProductDetailsBloc>(context),
                        child: const SpecSelectUi(
                          buyNow: true,
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.shopping_cart_checkout_rounded,
                        color: Colors.black),
                    Text(
                      val,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                  ],
                )),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/widgets/cart_lists.dart';
import 'package:innwa_mobile_dev/cart/widgets/total_price.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          appBar: TopBar(
            needBackButton: true,
            needMenu: false,
            showCart: false,
            title: "My Cart",
          ),
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
                        border: Border.all(width: 2, color: Colors.indigo),
                        color: Colors.white,
                      ),
                      child: LocalizationWidget(
                          en: "Back",
                          mm: "ထွက်မည်",
                          child: (val) {
                            return Center(
                                child: Text(
                              val,
                              style: GoogleFonts.roboto(
                                  fontSize: 20.0,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w600),
                            ));
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await RouterService.of(context)
                            .push(RouterPath.I.deliveryInfo.fullPath);
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: LocalizationWidget(
                            en: 'Check Out',
                            mm: "ပေးချေမည်",
                            child: (val) {
                              return Center(
                                  child: Text(
                                val,
                                style: GoogleFonts.roboto(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ));
                            }),
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

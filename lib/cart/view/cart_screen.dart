import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/cart/widgets/cart_item.dart';
import 'package:innwa_mobile_dev/cart/widgets/total_price.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: LocalizationWidget(
            en: "My Cart",
            mm: "ကျွန်ုပ်၏ခြင်းတောင်း",
            child: (val) {
              return Scaffold(
                appBar: TopBar(
                  needBackButton: true,
                  needMenu: false,
                  showCart: false,
                  title: val,
                ),
                bottomSheet: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.userCart.isNotEmpty
                        ? Container(
                            height: 130,
                            color: Colors.white,
                            child: Column(
                              children: [
                                5.vertical,
                                const TotalPrice(),
                                8.vertical,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2, color: Colors.indigo),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ));
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await RouterService.of(context).push(
                                              RouterPath
                                                  .I.deliveryInfo.fullPath);
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox();
                  },
                ),
                body: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return CustomScrollView(
                      slivers: [
                        if (state.userCart.isEmpty)
                          SliverToBoxAdapter(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                70.vertical,
                                const Icon(
                                  Icons.shopping_cart,
                                  size: 100,
                                ),
                                15.vertical,
                                LocalizationWidget(
                                  en: "Your cart is empty !",
                                  mm: "ခြင်းတောင်းထဲ တွင်ဘာမှမရှိပါ",
                                  child: (val) {
                                    return RobotoText(
                                      fontSize: 25,
                                      fontColor: Colors.grey.shade800,
                                      text: val,
                                      fontWeight: FontWeight.w600,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        SliverList.builder(
                          itemCount: state.userCart.length,
                          itemBuilder: (context, index) {
                            return CartItem(
                              isDelete: true,
                              isItemContorl: true,
                              isOrderHistory: false,
                              data: state.userCart[index],
                            );
                          },
                        ),
                        SliverToBoxAdapter(
                          child: 150.vertical,
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}

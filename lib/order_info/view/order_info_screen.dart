import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/cart/widgets/cart_item.dart';
import 'package:innwa_mobile_dev/order_info/bloc/order_info_bloc.dart';
import 'package:innwa_mobile_dev/order_info/widgets/deli_info.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/bottom_sheet.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class OrderInfoScreen extends StatelessWidget {
  const OrderInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderInfoBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final OrderInfoBloc orderInfoBloc =
            BlocProvider.of<OrderInfoBloc>(context)
              ..add(GetDeliveryFeeEvent(context: context));

        final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

        return BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            double subTotal = 0;

            for (var cart in state.userCart) {
              final ProductDetailsPriceModel price =
                  ProductDetailsPriceModel.fromJson(cart["product_price"]);
              subTotal += (price.price.toDouble() -
                      double.parse(price.disPrice ?? "0.0") -
                      double.parse(
                        price.cashback ?? "0",
                      )) *
                  cart["quantity"];
            }
            return Container(
              color: backgroundColorLight,
              child: SafeArea(
                child: LocalizationWidget(
                    en: "Checkout",
                    mm: "လုပ်ဆောင်မည်",
                    child: (checkOut) {
                      return Scaffold(
                        resizeToAvoidBottomInset: true,
                        appBar: TopBar(
                          needBackButton: true,
                          needMenu: false,
                          showCart: false,
                          title: checkOut,
                        ),
                        body: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 10.0, bottom: 15),
                                      child: LocalizationWidget(
                                          en: "Delivery Info",
                                          mm: "ပို့ဆောင်မှုအချက်အလက်",
                                          child: (val) {
                                            return RobotoText(
                                              fontSize: 18.0,
                                              fontColor: Colors.black,
                                              text: val,
                                              fontWeight: FontWeight.bold,
                                            );
                                          }),
                                    ),
                                    LocalizationWidget(
                                        en: "Name",
                                        mm: "နာမည်",
                                        child: (val) {
                                          return DeliInfo(
                                            leftText: val,
                                            rightText:
                                                cartBloc.nameController.text,
                                            isLongText: false,
                                          );
                                        }),
                                    LocalizationWidget(
                                        en: "Phone",
                                        mm: "ဖုန်း",
                                        child: (val) {
                                          return DeliInfo(
                                            leftText: val,
                                            rightText:
                                                "09${cartBloc.phoneController.text}",
                                            isLongText: false,
                                          );
                                        }),
                                    LocalizationWidget(
                                        en: "Email",
                                        mm: "အီးမေးလ်",
                                        child: (val) {
                                          return DeliInfo(
                                              leftText: val,
                                              rightText:
                                                  cartBloc.emailController.text,
                                              isLongText: false);
                                        }),
                                    LocalizationWidget(
                                      en: "State",
                                      mm: 'ပြည်နယ်',
                                      child: (val) {
                                        return LocalizationWidget(
                                            en: state.selectedState!.enName,
                                            mm: state.selectedState!.mmName,
                                            child: (state) {
                                              return DeliInfo(
                                                  leftText: val,
                                                  rightText: state,
                                                  isLongText: false);
                                            });
                                      },
                                    ),
                                    LocalizationWidget(
                                      en: "Township",
                                      mm: 'မြို့နယ်',
                                      child: (val) {
                                        return LocalizationWidget(
                                            en: state.selectedTownship!.enName,
                                            mm: state.selectedTownship!.mmName,
                                            child: (township) {
                                              return DeliInfo(
                                                leftText: val,
                                                rightText: township,
                                                isLongText: false,
                                              );
                                            });
                                      },
                                    ),
                                    LocalizationWidget(
                                        en: "Address",
                                        mm: "လိပ်စာ",
                                        child: (val) {
                                          return DeliInfo(
                                            leftText: val,
                                            rightText:
                                                cartBloc.addressController.text,
                                            isLongText: true,
                                          );
                                        }),
                                    LocalizationWidget(
                                      en: "Addition Note",
                                      mm: 'ထပ်လောင်းမှတ်စုများ',
                                      child: (val) {
                                        return DeliInfo(
                                            leftText: val,
                                            rightText: cartBloc
                                                .additionController.text,
                                            isLongText: false);
                                      },
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Divider(
                                        color: dividerColor,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: LocalizationWidget(
                                          en: "Order Summary",
                                          mm: "အော်ဒါ အကျဥ်းချုပ်",
                                          child: (val) {
                                            return RobotoText(
                                              fontSize: 18.0,
                                              fontColor: Colors.black,
                                              text: val,
                                              fontWeight: FontWeight.bold,
                                            );
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LocalizationWidget(
                                            en: "Sub Total",
                                            mm: "ကျသင့်ငွေ",
                                            child: (val) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    top: 10.0,
                                                    bottom: 10),
                                                child: RobotoText(
                                                  fontSize: 15.0,
                                                  fontColor: Colors.grey[700],
                                                  text: val,
                                                ),
                                              );
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: RobotoText(
                                            fontSize: 15.0,
                                            fontColor: Colors.grey[700],
                                            text:
                                                "${formatNumber(dbNumber: subTotal)} MMK",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LocalizationWidget(
                                            en: "Delivery Fee",
                                            mm: "ပို့ဆောင်ခ",
                                            child: (val) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: RobotoText(
                                                  fontSize: 15.0,
                                                  fontColor: Colors.grey[700],
                                                  text: val,
                                                ),
                                              );
                                            }),
                                        BlocBuilder<OrderInfoBloc,
                                            OrderInfoState>(
                                          builder: (context, orderInfoState) {
                                            return orderInfoState
                                                        .deliveryStatus ==
                                                    ApiStatus.completed
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0),
                                                    child: RobotoText(
                                                      fontSize: 15.0,
                                                      fontColor:
                                                          Colors.grey[700],
                                                      text:
                                                          "${state.deliFee?.fee ?? "0"} MMK",
                                                    ),
                                                  )
                                                : orderInfoState
                                                            .deliveryStatus ==
                                                        ApiStatus.processing
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      )
                                                    : LocalizationWidget(
                                                        en: "Retry !",
                                                        mm: "ထပ်မံကြိုးစားပါ !",
                                                        child: (val) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                orderInfoBloc
                                                                    .add(
                                                                  GetDeliveryFeeEvent(
                                                                    context:
                                                                        context,
                                                                  ),
                                                                );
                                                              },
                                                              child: RobotoText(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontColor:
                                                                    Colors.red,
                                                                text: val,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                          },
                                        ),
                                      ],
                                    ),
                                    if (state.coupon != null)
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Divider(
                                          color: dividerColor,
                                          height: 4,
                                        ),
                                      ),
                                    if (state.coupon != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  LocalizationWidget(
                                                    en: "Coupon Code",
                                                    mm: "ကူပွန်ကုဒ်",
                                                    child: (val) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0,
                                                                top: 10.0,
                                                                bottom: 10),
                                                        child: RobotoText(
                                                          fontSize: 15.0,
                                                          fontColor:
                                                              Colors.grey[700],
                                                          text: val,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  RobotoText(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontColor: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    text:
                                                        "  (${state.coupon!.couponCode})",
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  cartBloc.add(
                                                    ClearCouponEvent(
                                                      context: context,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(Icons.close),
                                              ),
                                            ],
                                          ),
                                          10.vertical,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (state.coupon!
                                                        .couponDisPrice !=
                                                    null)
                                                  LocalizationWidget(
                                                      en: "Discount",
                                                      mm: "လျော့ဈေး",
                                                      child: (val) {
                                                        return RobotoText(
                                                          fontSize: 15.0,
                                                          fontColor:
                                                              Colors.grey[700],
                                                          text: val,
                                                        );
                                                      }),
                                                if (state.coupon!
                                                        .couponDisPrice !=
                                                    null)
                                                  12.vertical,
                                                if (state.coupon!
                                                        .couponDisPrice !=
                                                    null)
                                                  RobotoText(
                                                    fontSize: 15.0,
                                                    fontColor: Colors.grey[700],
                                                    text:
                                                        "${formatNumber(dbNumber: state.coupon!.couponDisPrice)} MMK",
                                                  ),
                                              ],
                                            ),
                                          ),
                                          10.vertical,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (state.coupon!.gift != null)
                                                  LocalizationWidget(
                                                      en: "Gift",
                                                      mm: "လက်ဆောင်",
                                                      child: (val) {
                                                        return RobotoText(
                                                          fontSize: 15.0,
                                                          fontColor:
                                                              Colors.grey[700],
                                                          text: val,
                                                        );
                                                      }),
                                                if (state.coupon!.gift != null)
                                                  12.vertical,
                                                if (state.coupon!.gift != null)
                                                  RobotoText(
                                                    fontSize: 15.0,
                                                    fontColor: Colors.grey[700],
                                                    text:
                                                        "${state.coupon!.gift}",
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Divider(
                                        color: dividerColor,
                                        height: 4,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: LocalizationWidget(
                                              en: "Total",
                                              mm: "စုစုပေါင်း",
                                              child: (val) {
                                                return RobotoText(
                                                  fontSize: 15.0,
                                                  fontColor: Colors.grey[700],
                                                  text: val,
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: RobotoText(
                                            fontSize: 15.0,
                                            fontColor: Colors.grey[700],
                                            text: "${formatNumber(
                                              dbNumber: (subTotal +
                                                  double.parse(
                                                      state.deliFee?.fee ??
                                                          "0") -
                                                  (state.coupon
                                                          ?.couponDisPrice ??
                                                      0)),
                                            )} MMK",
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (state.coupon == null)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) {
                                                      return LocalizationWidget(
                                                          en: "Enter Coupon Code",
                                                          mm: "ကူပွန် ကုဒ်ကို ထည့်ပါ",
                                                          child: (val) {
                                                            return CustomBottomSheet(
                                                                text: val,
                                                                isPromo: true);
                                                          });
                                                    }).then((value) {
                                                  cartBloc.couponController
                                                      .text = "";
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15,
                                                    right: 10,
                                                    bottom: 10),
                                                child: LocalizationWidget(
                                                    en: "Enter Coupon Code",
                                                    mm: "ကူပွန်ကို ထည့်ပါ",
                                                    child: (val) {
                                                      return RobotoText(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontColor: Colors.blue,
                                                        text: val,
                                                      );
                                                    }),
                                              )),
                                        ],
                                      ),
                                    10.vertical,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: LocalizationWidget(
                                          en: "Items",
                                          mm: "ပစ္စည်းများ",
                                          child: (val) {
                                            return RobotoText(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              fontColor: null,
                                              text: val,
                                            );
                                          }),
                                    ),
                                    12.vertical,
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      decoration: const BoxDecoration(),
                                      child: ListView.builder(
                                        itemCount: state.userCart.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return CartItem(
                                            data: state.userCart[index],
                                            isDelete: false,
                                            isItemContorl: false,
                                            isOrderHistory: false,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      orderInfoBloc.add(ClickPaymentButtonEvent(
                                          context: context));
                                    },
                                    child: LocalizationWidget(
                                        en: "Select Payment Method",
                                        mm: "ငွေပေးချေမှုနည်းလမ်းကို ရွေးပါ",
                                        child: (val) {
                                          return Container(
                                            width: 350,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: primaryColor,
                                            ),
                                            child: Center(
                                                child: Text(
                                              val,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            );
          },
        );
      }),
    );
  }
}

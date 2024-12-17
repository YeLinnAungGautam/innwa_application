import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';
import 'package:innwa_mobile_dev/payment_select/bloc/payment_select_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/ui/innwa_error.dart';

import '../helpers/payment_methods_helper.dart';

class PaymentSelectScreen extends StatelessWidget {
  const PaymentSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaymentSelectBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final PaymentSelectBloc paymentSelectBloc =
            BlocProvider.of<PaymentSelectBloc>(context)
              ..add(GetPaymentMethodEvent(context: context));
        final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

        return Container(
          color: backgroundColorLight,
          child: SafeArea(
            child: LocalizationWidget(
                en: "Payments",
                mm: "ငွေပေးချေမှုနည်းလမ်းများ",
                child: (val) {
                  return Scaffold(
                    appBar: TopBar(
                      needBackButton: true,
                      needMenu: false,
                      showCart: false,
                      title: val,
                    ),
                    backgroundColor: backgroundColorLight,
                    body: BlocBuilder<PaymentSelectBloc, PaymentSelectState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: state.paymentGetStatus == ApiStatus.completed
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LocalizationWidget(
                                      en: "Please Choose Payment Options",
                                      mm: "ကျေးဇူးပြု၍ ငွေပေးချေမှုနည်းလမ်းများကို ရွေးချယ်ပါ",
                                      child: (val) {
                                        return RobotoText(
                                          fontSize: 20,
                                          fontColor: Colors.indigo,
                                          fontWeight: FontWeight.w600,
                                          text: val,
                                          maxLine: 2,
                                        );
                                      },
                                    ),
                                    10.vertical,
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(top: 15),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.payments.length,
                                        itemBuilder: (context, index) {
                                          String? imageLink;
                                          if (state.payments[index].name
                                                  .toLowerCase() ==
                                              "cash on delivery") {
                                            imageLink = Assets.images.cod.path;
                                          } else if (state.payments[index].name
                                                  .toLowerCase() ==
                                              "mpu") {
                                            imageLink = Assets.images.mpu.path;
                                          } else if (state.payments[index].name
                                                  .toLowerCase() ==
                                              "kbzpay") {
                                            imageLink = Assets.images.kpay.path;
                                          } else if (state.payments[index].name
                                                  .toLowerCase() ==
                                              "visa") {
                                            imageLink = Assets.images.visa.path;
                                          } else {
                                            imageLink =
                                                Assets.images.ayapay.path;
                                          }
                                          return BlocBuilder<CartBloc,
                                              CartState>(
                                            builder: (context, cartState) {
                                              return InkWell(
                                                onTap: () {
                                                  cartBloc.add(
                                                    SelectPaymentMethodEvent(
                                                      context: context,
                                                      payment:
                                                          state.payments[index],
                                                    ),
                                                  );

                                                  paymentSelectBloc.add(
                                                    SelectedPaymentEvent(
                                                        context: context,
                                                        paymentMethod:
                                                            PaymentMethodsHelper
                                                                .I
                                                                .paymentMethodType(
                                                                    state
                                                                        .payments[
                                                                            index]
                                                                        .id)),
                                                  );
                                                },
                                                child: _buildPaymentOptionCard(
                                                  context,
                                                  cartState,
                                                  state,
                                                  index,
                                                  imageLink,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        paymentSelectBloc.add(
                                          ClickOrderBtnEvent(context: context),
                                        );
                                      },
                                      child: _buildOrderBtn(context),
                                    )
                                  ],
                                )
                              : state.paymentGetStatus == ApiStatus.processing
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: InnwaError(onClick: () {
                                        paymentSelectBloc.add(
                                            GetPaymentMethodEvent(
                                                context: context));
                                      }),
                                    ),
                        );
                      },
                    ),
                  );
                }),
          ),
        );
      }),
    );
  }

  Widget _buildPaymentOptionCard(BuildContext context, CartState cartState,
      PaymentSelectState state, int index, String? imageLink) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: cartState.payment?.id == state.payments[index].id
            ? Border.all(
                color: primaryColor.withOpacity(0.75),
                width: 2,
              )
            : Border.all(
                color: primaryColor.withOpacity(0.25),
                width: 0.5,
              ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Opacity(
        opacity: cartState.payment?.id == state.payments[index].id ? 1 : 0.75,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: primaryColor),
                  ),
                  child: CircleAvatar(
                    maxRadius: 4,
                    backgroundColor:
                        cartState.payment?.id == state.payments[index].id
                            ? primaryColor
                            : Colors.white70,
                  ),
                ),
                Text(
                  state.payments[index].name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _buildLogo(state, index, imageLink),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(PaymentSelectState state, int index, String? imageLink) {
    return Container(
      width: state.payments[index].name.toLowerCase() == "mpu" ? 65 : 45,
      height: 45,
      padding: state.payments[index].name.toLowerCase() == "mpu"
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 10)
          : state.payments[index].name.toLowerCase() == "kpzpay"
              ? const EdgeInsets.all(10)
              : EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        imageLink ?? "",
        width: state.payments[index].name.toLowerCase() == "mpu" ? 64 : 45,
        height: 45,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildOrderBtn(BuildContext context) => LocalizationWidget(
      en: "Order",
      mm: "အော်ဒါတင်မည်",
      child: (val) {
        return Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
          ),
          child: Text(
            val,
            style: GoogleFonts.roboto(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        );
      });
}
/*
Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (imageLink != null)
                                                        CachedNetworkImage(
                                                          imageUrl: imageLink,
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      if (imageLink == null)
                                                        Image.asset(
                                                          Assets
                                                              .images.cod.path,
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      15.vertical,
                                                      Text(
                                                        state.payments[index]
                                                            .name,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    ],
                                                  )
*/

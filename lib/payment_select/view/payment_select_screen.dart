import 'package:cached_network_image/cached_network_image.dart';
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
                        return state.paymentGetStatus == ApiStatus.completed
                            ? Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0,
                                              left: 8.0,
                                              top: 15.0),
                                          child: LocalizationWidget(
                                              en: "Please Choose Payment Options",
                                              mm: "ကျေးဇူးပြု၍ ငွေပေးချေမှုနည်းလမ်းများကို ရွေးချယ်ပါ",
                                              child: (val) {
                                                return SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: RobotoText(
                                                    fontSize: 20,
                                                    fontColor: Colors.indigo,
                                                    fontWeight: FontWeight.w600,
                                                    text: val,
                                                    maxLine: 2,
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing: 10),
                                          itemCount: state.payments.length,
                                          itemBuilder: (context, index) {
                                            //
                                            //
                                            String? imageLink;
                                            if (state.payments[index].name
                                                        .toLowerCase() ==
                                                    "kbzpay" ||
                                                state.payments[index].name
                                                        .toLowerCase() ==
                                                    "kbz pay") {
                                              imageLink =
                                                  "https://shop.innwa.com.mm/img-src/payment/kbz pay logo.png";
                                            } else if (state
                                                    .payments[index].name
                                                    .toLowerCase() ==
                                                "mpu") {
                                              imageLink =
                                                  "https://shop.innwa.com.mm/img-src/payment/mpu logo.png";
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
                                                    ));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                      border: cartState.payment
                                                                  ?.id ==
                                                              state
                                                                  .payments[
                                                                      index]
                                                                  .id
                                                          ? Border.all(
                                                              color: Colors.red,
                                                              width: 2,
                                                            )
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Column(
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
                                                            Assets.images.cod
                                                                .path,
                                                            width: 80,
                                                            height: 80,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        15.vertical,
                                                        Text(
                                                          state.payments[index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              paymentSelectBloc.add(
                                                  ClickOrderBtnEvent(
                                                      context: context));
                                            },
                                            child: LocalizationWidget(
                                                en: "Order",
                                                mm: "အော်ဒါတင်မည်",
                                                child: (val) {
                                                  return Container(
                                                    width: 350,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: primaryColor,
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      val,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 20.0,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
}

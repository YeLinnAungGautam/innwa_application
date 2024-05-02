import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
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
      child: PromoBottomSheet(context, text),
    );
  }

  Padding PromoBottomSheet(BuildContext context, String text) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
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
                    text: text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10),
                child: LocalizationWidget(
                    en: "If you have a Wolt promo code or gift card, enter it below to claim your benefits.",
                    mm: "သင့်တွင် Wolt ပရိုမိုကုဒ် သို့မဟုတ် လက်ဆောင်ကတ်တစ်ခုရှိလျှင် သင့်အကျိုးခံစားခွင့်များကို တောင်းဆိုရန်အတွက် အောက်တွင် ထည့်သွင်းပါ။",
                    child: (val) {
                      return RobotoText(
                          fontSize: 15.0,
                          maxLine: 2,
                          fontColor: Colors.black,
                          text: val);
                    }),
              ),
            ],
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: LocalizationWidget(
                    en: "Promo Code",
                    mm: "ပရိုမိုကုဒ်",
                    child: (val) {
                      return LocalizationWidget(
                          en: "Enter Promo Code",
                          mm: "ပရိုမိုကုဒ်ထည့်ပါ",
                          child: (valText) {
                            return Form(
                              key: cartBloc.couponFormKey,
                              child: TextFormField(
                                autofocus: true,
                                controller: cartBloc.couponController,
                                validator: (val) {
                                  if (cartBloc.couponController.text.isEmpty) {
                                    return valText;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: val,
                                  labelStyle: const TextStyle(
                                    color: kTextFieldColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.black,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              )),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                cartBloc.add(ClickCouponApplyBtnEvent(context: context));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return Center(
                      child: LocalizationWidget(
                        en: "Checking",
                        mm: "စစ်ဆေးနေသည်",
                        child: (check) {
                          return LocalizationWidget(
                            en: "Apply",
                            mm: "လုပ်ဆောင်မည်",
                            child: (apply) {
                              return Text(
                                state.checkCouponStatus == ApiStatus.completed
                                    ? apply
                                    : check,
                                style: GoogleFonts.roboto(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

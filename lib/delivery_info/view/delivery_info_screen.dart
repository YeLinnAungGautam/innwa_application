import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/delivery_info/bloc/delivery_info_bloc.dart';
import 'package:innwa_mobile_dev/delivery_info/widgets/state_dropdown.dart';
import 'package:innwa_mobile_dev/delivery_info/widgets/township_dropdown.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class DeliveryInfoScreen extends StatefulWidget {
  const DeliveryInfoScreen({super.key});

  @override
  State<DeliveryInfoScreen> createState() => _DeliveryInfoScreenState();
}

class _DeliveryInfoScreenState extends State<DeliveryInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeliveryInfoBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final DeliveryInfoBloc deliveryInfoBloc =
            BlocProvider.of<DeliveryInfoBloc>(context)
              ..add(GetStateEvent(context: context));
        return LocalizationWidget(
            en: "Deliver Address",
            mm: "ပေးပို့ရန်လိပ်စာ",
            child: (deliAddress) {
              final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
              return Container(
                color: backgroundColorLight,
                child: SafeArea(
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.white,
                    drawer: CustomDrawerWidget(onDrawerTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.hasFocus) {
                        currentFocus.unfocus();
                      }
                    }),
                    appBar: TopBar(
                      needBackButton: true,
                      needMenu: false,
                      showCart: false,
                      title: deliAddress,
                    ),
                    body: Container(
                      color: Colors.grey.shade300.withOpacity(0.5),
                      child: Form(
                        key: cartBloc.formKey,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  Column(
                                    children: [
                                      15.vertical,
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 10.0),
                                            child: RobotoText(
                                                fontSize: 16.0,
                                                fontColor: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                text:
                                                    "Please fill following information"),
                                          ),
                                        ],
                                      ),
                                      15.vertical,
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: LocalizationWidget(
                                            en: "Name",
                                            mm: "အမည်",
                                            child: (name) {
                                              return LocalizationWidget(
                                                en: "Please Fill The User Name!",
                                                mm: "အသုံးပြုသူအမည်ကို ဖြည့်ပါ!",
                                                child: (text) {
                                                  return CustomTextFormField(
                                                    onChanged: (val) {
                                                      cartBloc.nameController
                                                          .text = val;
                                                    },
                                                    needBackground: true,
                                                    label: name,
                                                    validator: (value) {
                                                      if (cartBloc
                                                          .nameController
                                                          .text
                                                          .isEmpty) {
                                                        return text;
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: () => {},
                                                    pass: false,
                                                  );
                                                },
                                              );
                                            }),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: LocalizationWidget(
                                            en: "Phone Number Must Be At Least Eight Or Nine",
                                            mm: "ဖုန်းနံပါတ် အနည်းဆုံး ရှစ်ခု ကိုးခု ရှိရမယ်",
                                            child: (atLeastEight) {
                                              return LocalizationWidget(
                                                  en: "Phone Number Must Be At Least Seven",
                                                  child: (atLeastSeven) {
                                                    return LocalizationWidget(
                                                        en: "Please Fill The Phone Number",
                                                        mm: "ဖုန်းနံပါတ် ခုနစ်ခု အနည်းဆုံးရှိရမည်",
                                                        child: (fillPhone) {
                                                          return LocalizationWidget(
                                                              en: "Phone",
                                                              mm: "ဖုန်း",
                                                              child: (phone) {
                                                                return CustomTextFormField(
                                                                  needBackground:
                                                                      true,
                                                                  label: phone,
                                                                  prefix:
                                                                      const Text(
                                                                          "09"),
                                                                  onChanged:
                                                                      (val) {
                                                                    cartBloc
                                                                        .phoneController
                                                                        .text = val;
                                                                  },
                                                                  onSaved: () =>
                                                                      {},
                                                                  validator:
                                                                      (value) {
                                                                    debugPrint(
                                                                        "-----------Value ---------------------$value--------------------------------");
                                                                    if (value !=
                                                                            null &&
                                                                        value
                                                                            .isEmpty) {
                                                                      return fillPhone;
                                                                    } else if (value !=
                                                                            null &&
                                                                        value
                                                                            .isNotEmpty) {
                                                                      if (value
                                                                              .length <=
                                                                          6) {
                                                                        return atLeastSeven;
                                                                      }
                                                                      if (value
                                                                              .length >
                                                                          9) {
                                                                        return atLeastEight;
                                                                      }
                                                                    }
                                                                    return null;
                                                                  },
                                                                  pass: false,
                                                                );
                                                              });
                                                        });
                                                  });
                                            }),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: LocalizationWidget(
                                            en: "Email",
                                            mm: "အီးမေးလ်",
                                            child: (email) {
                                              return LocalizationWidget(
                                                  en: "Please Fill The Email !",
                                                  mm: "ကျေးဇူးပြု၍ အီးမေးလ် ဖြည့်ပါ။",
                                                  child: (pleaseFill) {
                                                    return LocalizationWidget(
                                                      en: "Your Email Is Invalid!",
                                                      mm: "သင်၏အီးမေးလ်သည် မမှန်ကန်ပါ!",
                                                      child: (invalid) {
                                                        return CustomTextFormField(
                                                          needBackground: true,
                                                          label: "Email",
                                                          onChanged: (val) {
                                                            cartBloc
                                                                .emailController
                                                                .text = val;
                                                          },
                                                          validator: (val) {
                                                            final RegExp
                                                                emailRegex =
                                                                RegExp(
                                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                                            if (cartBloc
                                                                .emailController
                                                                .text
                                                                .isEmpty) {
                                                              return pleaseFill;
                                                            } else if (!emailRegex
                                                                .hasMatch(cartBloc
                                                                    .emailController
                                                                    .text)) {
                                                              return invalid;
                                                            }
                                                            return null;
                                                          },
                                                          onSaved: () => {},
                                                          pass: false,
                                                        );
                                                      },
                                                    );
                                                  });
                                            }),
                                      ),
                                      const StateDropDown(),
                                      BlocBuilder<CartBloc, CartState>(
                                        builder: (context, state) {
                                          return state.selectedState != null
                                              ? const TownshipDropDown()
                                              : const SizedBox();
                                        },
                                      ),
                                      LocalizationWidget(
                                          en: "Please Fill The Address !",
                                          mm: "ကျေးဇူးပြု၍ လိပ်စာ ဖြည့်ပါ။",
                                          child: (plsFillAddress) {
                                            return LocalizationWidget(
                                                en: "Address",
                                                mm: 'လိပ်စာ',
                                                child: (address) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: CustomTextFormField(
                                                      needBackground: true,
                                                      label: address,
                                                      onChanged: (val) {
                                                        cartBloc
                                                            .addressController
                                                            .text = val;
                                                      },
                                                      onSaved: () => {},
                                                      validator: (value) {
                                                        if (cartBloc
                                                            .addressController
                                                            .text
                                                            .isEmpty) {
                                                          return plsFillAddress;
                                                        }
                                                        return null;
                                                      },
                                                      pass: false,
                                                    ),
                                                  );
                                                });
                                          }),
                                      LocalizationWidget(
                                          en: "Please Fill The Addition Note !",
                                          mm: "ကျေးဇူးပြု၍ ထပ်လောင်းမှတ်စုများ ဖြည့်ပါ။",
                                          child: (plsFill) {
                                            return LocalizationWidget(
                                                en: "Addition Note",
                                                mm: 'ထပ်လောင်းမှတ်စုများ',
                                                child: (note) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: CustomTextFormField(
                                                      needBackground: true,
                                                      onChanged: (val) {
                                                        cartBloc
                                                            .additionController
                                                            .text = val;
                                                      },
                                                      validator: (value) {
                                                        if (cartBloc
                                                            .additionController
                                                            .text
                                                            .isEmpty) {
                                                          return plsFill;
                                                        }
                                                        return null;
                                                      },
                                                      label: note,
                                                      onSaved: () => {},
                                                      pass: false,
                                                    ),
                                                  );
                                                });
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, bottom: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    deliveryInfoBloc.add(
                                        ClickNextBtnEvent(context: context));
                                  },
                                  // onTap: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const Order())),
                                  child: Container(
                                    width: 350,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor,
                                    ),
                                    child: Center(
                                        child: LocalizationWidget(
                                            en: "Next",
                                            mm: "ဆက်လက်လုပ်ဆောင်ရန်",
                                            child: (val) {
                                              return Text(
                                                val,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              );
                                            })),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}

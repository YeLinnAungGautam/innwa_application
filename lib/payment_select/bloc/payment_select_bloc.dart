import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/model.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/payment_select/helpers/url_launching.dart';
import 'package:innwa_mobile_dev/payment_select/helpers/web_view_helper.dart';
import 'package:innwa_mobile_dev/payment_select/model/payment_model.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../_application/router_service/route_path.dart';
import '../../_application/router_service/router_service.dart';
import '../../_application/service/api_service/util.dart';
import '../../_application/service/localization/loclaization_view.dart';
import '../../_application/service/storage/storage_service.dart';
import '../../product_details/model/product_details_model.dart';
import '../../shared/texts/roboto_text/roboto_text.dart';
import '../../util/constants.dart';
import '../../util/ui/innwa_loading.dart';
import '../../util/ui/snack_bar.dart';
import '../helpers/payment_methods_helper.dart';

part 'payment_select_event.dart';
part 'payment_select_state.dart';

class PaymentSelectBloc extends Bloc<PaymentSelectEvent, PaymentSelectState> {
  PaymentSelectBloc(this._restAPI) : super(const PaymentSelectState()) {
    on<GetPaymentMethodEvent>(_getPaymentMethodEvent);
    on<ClickOrderBtnEvent>(_clickOrderBtn);
    on<SelectedPaymentEvent>(_selectedPayment);
  }

  final RestAPI _restAPI;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiredMonthController = TextEditingController();
  final TextEditingController expiredYearController = TextEditingController();

  Future<void> _selectedPayment(
      SelectedPaymentEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        paymentMethod: event.paymentMethod,
      ),
    );

    log('payemnt method ==> ${state.paymentMethod}');
    if (state.paymentMethod == PaymentMethodType.visa &&
        event.context.mounted) {
      modelBottomVisaForm(event.context, onTapConfirm: () {
        if (_key.currentState!.validate()) {
          RouterService.of(event.context).pop();
          log("card number : ${cardNumberController.text} exp month : ${expiredMonthController.text} exp year : ${expiredYearController.text}");
        } else {
          log('user need to fill form to make payment with visa');
        }
      });
    }

    /// aya pay qr session
    if (state.paymentMethod == PaymentMethodType.ayaPayQr) {
      log("selected is : aya pay qr");
      if (!event.context.mounted) return;
      showSnackBar(
        message:
            "Aya pay QR is currently unavailable. Please process with another payment.",
        title: "Unavailable",
        context: event.context,
        backgroundColor: Colors.amber,
        messageColor: Colors.black,
        titleColor: Colors.black,
      );
    }
  }

  Future<void> _clickOrderBtn(ClickOrderBtnEvent event, Emitter emit) async {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(event.context);
    if (cartBloc.state.payment == null) {
      showSnackBar(
        message: "You need to select the payment.",
        title: "Payment Select",
        context: event.context,
        backgroundColor: Colors.amber,
        messageColor: Colors.black,
        titleColor: Colors.black,
      );
    }

    /// aya pay qr session
    else if (state.paymentMethod == PaymentMethodType.ayaPayQr) {
      log("selected is : aya pay qr");
      if (!event.context.mounted) return;
      showSnackBar(
        message:
            "Aya pay QR is currently unavailable. Please process with another payment.",
        title: "Unavailable",
        context: event.context,
        backgroundColor: Colors.amber,
        messageColor: Colors.black,
        titleColor: Colors.black,
      );
    } else {
      if (!event.context.mounted) return;

      final innwaLoading = InnwaLoading(context: event.context)
        ..showLoadingSpinner();
      double subTotal = 0;

      for (var cart in cartBloc.state.userCart) {
        final ProductDetailsPriceModel price =
            ProductDetailsPriceModel.fromJson(cart["product_price"]);
        subTotal += (price.price.toDouble() -
                double.parse(price.disPrice ?? "0.0") -
                double.parse(
                  price.cashback ?? "0",
                ) -
                (cartBloc.state.coupon?.couponDisPrice ?? 0)) *
            cart["quantity"];
      }

      final sendData = {
        "payment_id": cartBloc.state.payment!.id,
        "items": cartBloc.state.userCart.map((e) {
          e["product_price"]["product_price_id"] = e["product_price"]["id"];
          e = e;
          return e;
        }).toList(),
        "state_id": cartBloc.state.selectedState!.id,
        "township_id": cartBloc.state.selectedTownship!.id,
        "phone": "09${cartBloc.phoneController.text}",
        "coupon_code": cartBloc.state.coupon?.couponCode,
        "name": cartBloc.nameController.text,
        "email": cartBloc.emailController.text,
        "address": cartBloc.addressController.text,
        "addition": cartBloc.additionController.text,
        "sub_total":
            subTotal + double.parse(cartBloc.state.deliFee?.fee ?? "0"),
      };
      debugPrint("order id : ${cartBloc.state.payment!.id}");

      final resData = await _order(data: sendData);

      innwaLoading.closeLoadingSpinner();
      if (resData != null) {
        if (resData["status"] == "error" && event.context.mounted) {
          showSnackBar(
            message: resData["message"] ?? "",
            title: "Order Error",
            context: event.context,
            backgroundColor: Colors.amber,
            messageColor: Colors.black,
            titleColor: Colors.black,
          );
        } else {
          Map<String, dynamic>? res;

          if (state.paymentMethod == PaymentMethodType.cod) {
            log("selected is : cod");
          }

          /// kbz pay session
          if (state.paymentMethod == PaymentMethodType.kbzPay) {
            log("selected is : kbz");

            final kbzPayment = {
              "order_id": resData["order"]["id"],
              "customer_phone": resData["order"]["customer_phone"],
            };
            res = await _makePayment(data: kbzPayment);
            log("kpz pay res data : $res");
          }

          /// aya pay pin session
          if (state.paymentMethod == PaymentMethodType.ayaPayPin) {
            log("selected is : aya pay pin");

            final ayaPayPinPayment = {
              "order_id": resData["order"]["id"],
              "customer_phone": resData["order"]["customer_phone"],
            };
            res = await _makePayment(data: ayaPayPinPayment);
            log("aya pay pin res data : $res");
          }

          /// mpu pay session
          if (state.paymentMethod == PaymentMethodType.mpu) {
            log("selected is : mpu");

            final mpuPayment = {
              "order_id": resData["order"]["id"],
            };
            res = await _makePayment(data: mpuPayment);
            log("mpu res data : $res");
          }

          /// visa pay session
          if (state.paymentMethod == PaymentMethodType.visa) {
            log("selected is : visa");

            final visaPayment = {
              "order_id": resData["order"]["id"],
              "card_number": cardNumberController.text,
              "expiration_month": expiredMonthController.text,
              "expiration_year": expiredYearController.text,
            };
            res = await _makePayment(data: visaPayment);
            log("visa pay res data : $res");
          }

          if (!event.context.mounted) return;
          await showSnackBar(
            message: resData["message"] ?? "",
            title: "Order",
            context: event.context,
            backgroundColor: Colors.green,
            messageColor: Colors.black,
            titleColor: Colors.black,
          );

          final String? redirectUrl = res?["redirect_url"];

          Future.delayed(const Duration(milliseconds: 500), () async {
            if (state.paymentMethod == PaymentMethodType.mpu) {
              final String? url = res?["mpu_form"];

              log("mpu form res : $url");

              if (url != null) {
                await alertBox(
                  event.context,
                  capitalizeStartWord("Order Success!"),
                  "Continue process the payment with MPU",
                  () async {
                    log("go to mpu portal");

                    Navigator.of(event.context).push(MaterialPageRoute(
                      builder: (context) => MyWebView(url: url),
                    ));
                  },
                );
              }
            }

            if (state.paymentMethod == PaymentMethodType.kbzPay) {
              await alertBox(
                event.context,
                capitalizeStartWord(res?["status"]),
                res?["message"],
                () async {
                  if (!event.context.mounted) return;
                  cartBloc.add(ClearOrderDataEvent(context: event.context));
                  _disposeCtr();

                  if (redirectUrl != null) {
                    UrlLaunching.I.launchKPZPay(redirectUrl);
                  }
                  await Future.delayed(const Duration(milliseconds: 300), () {
                    RouterService.of(event.context).push(
                      RouterPath.I.home.fullPath,
                      redirect: true,
                    );
                  });
                },
              );
            }
          });
        }
      }
      debugPrint(
          "-----------Go To Server------$sendData-----------------------------------------------");
    }
  }

  void _disposeCtr() {
    cardNumberController.clear();
    expiredMonthController.clear();
    expiredYearController.clear();

    cardNumberController.dispose();
    expiredMonthController.dispose();
    expiredYearController.dispose();
  }

  modelBottomVisaForm(BuildContext context,
      {void Function()? onTapConfirm}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      scrollControlDisabledMaxHeightRatio:
          MediaQuery.of(context).size.height * 0.8,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RobotoText(
                        fontSize: 20,
                        fontColor: Colors.indigo,
                        fontWeight: FontWeight.w600,
                        text: "Visa Payment ",
                        maxLine: 1,
                      ),
                      IconButton(
                        onPressed: () {
                          RouterService.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                        color: Colors.indigo,
                      )
                    ],
                  ),
                ),
                10.vertical,
                LocalizationWidget(
                    en: "Visa Card Number",
                    mm: "ဗီဇာ ကဒ်နံပတ်",
                    child: (name) {
                      return LocalizationWidget(
                        en: "Please Fill Visa Card Number!",
                        mm: "ကျေးဇူးပြု၍ ဗီဇာ ကဒ်နံပတ်ကို ဖြည့်ပါ!",
                        child: (text) {
                          return CustomTextFormField(
                            textStyle: const TextStyle(color: Colors.black87),
                            initialData: cardNumberController.text,
                            textInputType: TextInputType.number,
                            onChanged: (val) {
                              cardNumberController.text = val;
                            },
                            needBackground: true,
                            label: name,
                            validator: (value) {
                              if (cardNumberController.text.isEmpty) {
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
                10.vertical,
                LocalizationWidget(
                    en: "Visa Card's Expired Month",
                    mm: "ဗီဇာကဒ်၏ သက်တမ်းကုန်မည့်လ",
                    child: (name) {
                      return LocalizationWidget(
                        en: "Please Fill Visa Card's Expired Month!",
                        mm: "ကျေးဇူးပြု၍ ဗီဇာကဒ်၏ သက်တမ်းကုန်မည့်လကို ဖြည့်ပါ!",
                        child: (text) {
                          return CustomTextFormField(
                            textStyle: const TextStyle(color: Colors.black87),
                            initialData: expiredMonthController.text,
                            textInputType: TextInputType.number,
                            onChanged: (val) {
                              expiredMonthController.text = val;
                            },
                            needBackground: true,
                            label: name,
                            validator: (value) {
                              if (expiredMonthController.text.isEmpty) {
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
                10.vertical,
                LocalizationWidget(
                    en: "Visa Card's Expired Year",
                    mm: "ဗီဇာကဒ်၏ သက်တမ်းကုန်မည့်နှစ်",
                    child: (name) {
                      return LocalizationWidget(
                        en: "Please Fill Visa Card's Expired Year!",
                        mm: "ကျေးဇူးပြု၍ ဗီဇာကဒ်၏ သက်တမ်းကုန်မည့်နှစ်ကို ဖြည့်ပါ!",
                        child: (text) {
                          return CustomTextFormField(
                            textStyle: const TextStyle(color: Colors.black87),
                            initialData: expiredYearController.text,
                            textInputType: TextInputType.number,
                            onChanged: (val) {
                              expiredYearController.text = val;
                            },
                            needBackground: true,
                            label: name,
                            validator: (value) {
                              if (expiredYearController.text.isEmpty) {
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
                const Spacer(),
                LocalizationWidget(
                    en: "Confirm",
                    mm: "အတည်ပြုမည်",
                    child: (val) {
                      return InkWell(
                        onTap: onTapConfirm,
                        child: Container(
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
                        ),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  static String capitalizeStartWord(String text) {
    if (text.isEmpty) return text;

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  Future<void> alertBox(
    BuildContext context,
    String? title,
    String? subTitle,
    void Function()? onClosed,
  ) async {
    await showAdaptiveDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            insetPadding: const EdgeInsets.all(20),
            insetAnimationDuration: const Duration(milliseconds: 800),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RobotoText(
                    fontSize: 18,
                    fontColor: Colors.indigo,
                    fontWeight: FontWeight.w600,
                    text: title,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: RobotoText(
                      fontSize: 16,
                      fontColor: Colors.black87,
                      fontWeight: FontWeight.w500,
                      text: subTitle,
                    ),
                  ),
                  InkWell(
                    onTap: onClosed,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: RobotoText(
                        fontSize: 16,
                        fontColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        text: "Continue",
                        maxLine: 1,
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  Future<Map<String, dynamic>?> _order(
      {required Map<String, dynamic> data}) async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "POST",
      path: ApiKey.order,
      error: error,
      data: data,
      timeOutError: error,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = null;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }

  Future<Map<String, dynamic>?> _makePayment(
      {required Map<String, dynamic> data}) async {
    final String? authToken = await StorageService.I
        .readData(key: StorageService.I.authTokenStoreKey);
    try {
      // Create a Dio instance or use an existing one if already set up
      final dio = Dio();
      // Add PrettyDioLogger as an interceptor
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          // Logs request body
          responseHeader: true,
          // Logs response headers
          responseBody: true,
          // Logs response body
          error: true,
          // Logs errors
          compact: true,
          // Makes the log output more compact
          maxWidth: 90, // Width limit for log lines (good for formatting)
        ),
      );

      // Send the POST request to the payment endpoint
      final response = await dio.post(
        ApiKey.base + ApiKey.makePayment, // Your API endpoint for the payment
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json', // Set appropriate headers
            // Add any authorization headers if needed
          },
          // Optionally, set a timeout
          sendTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 5000),
        ),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse and return the response data
        return response.data as Map<String, dynamic>;
      } else {
        // Handle the error response as needed
        printError("Payment failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Catch any errors, like network issues or timeouts
      printError("Error during payment: $e");
      return null;
    }
  }

  Future<void> _getPaymentMethodEvent(
    GetPaymentMethodEvent event,
    Emitter emit,
  ) async {
    emit(state.copyWith(paymentGetStatus: ApiStatus.processing));
    final resData = await _getpayments();
    if (resData != null) {
      final jsonData = resData["payments"] as List;
      final List<PaymentModel> data =
          jsonData.map((e) => PaymentModel.fromJson(e)).toList();
      emit(state.copyWith(
          paymentGetStatus: ApiStatus.completed, payments: data));
    } else {
      emit(state.copyWith(paymentGetStatus: ApiStatus.failure));
    }
  }

  Future<Map<String, dynamic>?> _getpayments() async {
    Map<String, dynamic>? resData;
    final CallBackConfig error = CallBackConfig(
      allowBoth: true,
      onCallBack: () async {
        resData = null;
      },
    );
    await _restAPI.api.query<Map<String, dynamic>>(
      method: "GET",
      path: ApiKey.paymentMethod,
      error: error,
      timeOutError: error,
      isAlreadyToken: false,
      afterValidate: AfterCallBackConfig(
          allowBoth: true,
          onCallBack: (value, result) async {
            if (!result!) {
              resData = null;
            }
            return result;
          }),
      onSuccess: (value) async {
        resData = value;
      },
    );
    return resData;
  }
}

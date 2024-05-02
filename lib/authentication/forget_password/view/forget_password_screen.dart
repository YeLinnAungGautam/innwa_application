import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/authentication/forget_password/bloc/forget_password_bloc.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      ),
      child: Builder(builder: (context) {
        final ForgetPasswordBloc forgetPasswordBloc =
            BlocProvider.of<ForgetPasswordBloc>(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Form(
              key: forgetPasswordBloc.formKey,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: LocalizationWidget(
                      en: "Forget Password?",
                      mm: "စကားဝှက်ကိုမေ့နေသလား",
                      child: (val) {
                        return Text(
                          val,
                          style: GoogleFonts.roboto(
                            fontSize: 35.0,
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 20.vertical,
                  ),
                  SliverToBoxAdapter(
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
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: CustomTextFormField(
                                        label: email,
                                        needBackground: true,
                                        onChanged: (val) {
                                          forgetPasswordBloc.email.text = val;
                                        },
                                        onSaved: () {},
                                        validator: (val) {
                                          final RegExp emailRegex = RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                          if (forgetPasswordBloc
                                              .email.text.isEmpty) {
                                            return pleaseFill;
                                          } else if (!emailRegex.hasMatch(
                                            forgetPasswordBloc.email.text,
                                          )) {
                                            return invalid;
                                          }
                                          return null;
                                        },
                                        pass: false,
                                      ),
                                    );
                                  });
                            });
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 20.vertical,
                  ),
                  BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                    builder: (context, state) {
                      return SliverToBoxAdapter(
                        child: GestureDetector(
                          onTap: () {
                            if (state.sendStatus == ApiStatus.completed) {
                              forgetPasswordBloc.add(
                                  SubmitForgetPasswordEvent(context: context));
                            }
                          },
                          child: Container(
                            width: 240,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),
                            child: LocalizationWidget(
                              en: "Submit",
                              mm: "အတည်ပြုပါ",
                              child: (val) {
                                return Center(
                                  child: Text(
                                    state.sendStatus == ApiStatus.processing
                                        ? "Loading.."
                                        : val,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
        );
      }),
    );
  }
}

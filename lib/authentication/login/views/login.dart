import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/authentication/login/bloc/login_bloc.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/image_container/image_container.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/image_path/image_path.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  ImagePath imaPath = ImagePath();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final LoginBloc loginBloc = BlocProvider.of(context);
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Form(
                  key: loginBloc.loginKey,
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ImageContainer(
                                      isUrl: false,
                                      width: 205.0,
                                      height: 60.0,
                                      url: imaPath.path('innwa_logo.png')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LocalizationWidget(
                                      en: "Welcome Back",
                                      mm: "ကြိုဆိုပါတယ်",
                                      child: (val) {
                                        return Text(
                                          val,
                                          style: GoogleFonts.roboto(
                                              fontSize: 30.0,
                                              color: Colors.black),
                                        );
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LocalizationWidget(
                                      en: "Sign in to Continue",
                                      mm: "ဆက်လုပ်ရန် အကောင့်ဝင်ပါ",
                                      child: (val) {
                                        return Text(
                                          val,
                                          style: GoogleFonts.roboto(
                                              fontSize: 18.0,
                                              color: Colors.black45),
                                        );
                                      }),
                                ),
                                LocalizationWidget(
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
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: CustomTextFormField(
                                                      needBackground: true,
                                                      label: email,
                                                      onSaved: () => {},
                                                      onChanged: (val) {
                                                        loginBloc.add(
                                                            UpdateLoginEmailEvent(
                                                                context:
                                                                    context,
                                                                data: val));
                                                      },
                                                      validator: (val) {
                                                        final RegExp
                                                            emailRegex = RegExp(
                                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                                        if (state
                                                            .email.isEmpty) {
                                                          return pleaseFill;
                                                        } else if (!emailRegex
                                                            .hasMatch(
                                                                state.email)) {
                                                          return invalid;
                                                        }
                                                        return null;
                                                      },
                                                      pass: false,
                                                    ),
                                                  );
                                                });
                                          });
                                    }),
                                LocalizationWidget(
                                    en: "Password",
                                    mm: "စကားဝှက်",
                                    child: (pass) {
                                      return LocalizationWidget(
                                          en: "Please Fill The Password!",
                                          mm: "စကားဝှက်ကို ဖြည့်ပါ!",
                                          child: (fillPass) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: CustomTextFormField(
                                                needBackground: true,
                                                label: pass,
                                                onSaved: () => {},
                                                onChanged: (val) {
                                                  loginBloc.add(
                                                      UpdateLoginPasswordEvent(
                                                          context: context,
                                                          data: val));
                                                },
                                                validator: (value) {
                                                  if (state.password.isEmpty) {
                                                    return fillPass;
                                                  }

                                                  return null;
                                                },
                                                pass: true,
                                              ),
                                            );
                                          });
                                    }),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 9.0),
                                      child: SizedBox(),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (state.sendStatus ==
                                        ApiStatus.completed) {
                                      loginBloc.add(
                                          ClickLoginBtnEvent(context: context));
                                    }
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor,
                                    ),
                                    child: LocalizationWidget(
                                        en: "Login",
                                        mm: "လော့ဂ်အင်",
                                        child: (val) {
                                          return Center(
                                              child: Text(
                                            state.sendStatus ==
                                                    ApiStatus.processing
                                                ? "Loading.."
                                                : val,
                                            style: GoogleFonts.roboto(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ));
                                        }),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                                //   child: Text(
                                //     "or",
                                //     style: GoogleFonts.roboto(
                                //         color: Colors.black54, fontSize: 18.0),
                                //   ),
                                // ),
                                // GestureDetector(
                                //   onTap: () {},
                                //   child: Container(
                                //     width: 300,
                                //     height: 50,
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(50),
                                //       color: Colors.white,
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         ImageContainer(
                                //             isUrl: false,
                                //             width: 50,
                                //             height: 50,
                                //             url: imaPath.path('google_logo.png')),
                                //         Text(
                                //           'Login In with Google',
                                //           style: GoogleFonts.roboto(
                                //               fontSize: 18.0,
                                //               color: Colors.black87,
                                //               fontWeight: FontWeight.w600),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 20.0,
                                      top: 45.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          LocalizationWidget(
                                              en: "Don't Have Account?",
                                              mm: "အကောင့်မရှိဘူးလား?",
                                              child: (val) {
                                                return RobotoText(
                                                  fontSize: 15.0,
                                                  fontColor: Colors.black,
                                                  text: val,
                                                );
                                              }),
                                          InkWell(
                                            onTap: () {
                                              RouterService.of(context).push(
                                                RouterPath.I.register.fullPath,
                                              );
                                            },
                                            child: LocalizationWidget(
                                                en: "Register Here",
                                                mm: "ဒီမှာ စာရင်းသွင်းပါ",
                                                child: (val) {
                                                  return RobotoText(
                                                    fontSize: 15.0,
                                                    fontColor: primaryColor,
                                                    text: val,
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Padding buildInputForm(String label, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: kTextFieldColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.black54)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/authentication/register/bloc/register_bloc.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/image_path/image_path.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  ImagePath imaPath = ImagePath();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      ),
      child: Builder(builder: (context) {
        final RegisterBloc registerBloc = BlocProvider.of(context);
        return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: Form(
                  key: registerBloc.registerKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 19.0, bottom: 8.0),
                                    child: Row(
                                      children: [
                                        LocalizationWidget(
                                            en: "Create Account",
                                            mm: "အကောင့်ပြုလုပ်ပါ",
                                            child: (val) {
                                              return Text(
                                                val,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 35.0,
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                  LocalizationWidget(
                                      en: "User Name",
                                      mm: "အသုံးပြုသူအမည်",
                                      child: (val) {
                                        return LocalizationWidget(
                                            en: "Please Fill The User Name!",
                                            mm: "အသုံးပြုသူအမည်ကို ဖြည့်ပါ!",
                                            child: (fillPass) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: CustomTextFormField(
                                                  label: val,
                                                  onChanged: (val) {
                                                    registerBloc.add(
                                                        UpdateNameEvent(
                                                            context: context,
                                                            data: val));
                                                  },
                                                  needBackground: true,
                                                  validator: (value) {
                                                    if (state.name.isEmpty) {
                                                      return fillPass;
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: () => {},
                                                  pass: false,
                                                ),
                                              );
                                            });
                                      }),
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
                                                      child:
                                                          CustomTextFormField(
                                                        label: email,
                                                        needBackground: true,
                                                        onChanged: (val) {
                                                          registerBloc.add(
                                                              UpdateEmailEvent(
                                                            context: context,
                                                            data: val,
                                                          ));
                                                        },
                                                        onSaved: () {},
                                                        validator: (val) {
                                                          final RegExp
                                                              emailRegex =
                                                              RegExp(
                                                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                                          if (state
                                                              .email.isEmpty) {
                                                            return pleaseFill;
                                                          } else if (!emailRegex
                                                              .hasMatch(state
                                                                  .email)) {
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
                                      en: "New Password",
                                      mm: "စကားဝှက်အသစ်",
                                      child: (newPass) {
                                        return LocalizationWidget(
                                            en: "Please Fill The Password!",
                                            mm: "ကျေးဇူးပြု၍ Password ဖြည့်ပါ!",
                                            child: (pleaseFill) {
                                              return LocalizationWidget(
                                                  en: "Password And Confirm Password Doesn't Match!",
                                                  mm: "Password နှင့် Confirm Password မကိုက်ညီပါ!",
                                                  child: (notMatch) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 8.0),
                                                      child:
                                                          CustomTextFormField(
                                                        label: newPass,
                                                        needBackground: true,
                                                        onSaved: () {},
                                                        onChanged: (val) {
                                                          registerBloc.add(
                                                              UpdatePasswordEvent(
                                                            context: context,
                                                            data: val,
                                                          ));
                                                        },
                                                        validator: (value) {
                                                          if (state.password
                                                              .isEmpty) {
                                                            return pleaseFill;
                                                          }
                                                          if (state.password
                                                                  .isNotEmpty &&
                                                              state
                                                                  .confirmPassword
                                                                  .isNotEmpty) {
                                                            if (state
                                                                    .password !=
                                                                state
                                                                    .confirmPassword) {
                                                              return notMatch;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                        pass: true,
                                                      ),
                                                    );
                                                  });
                                            });
                                      }),
                                  LocalizationWidget(
                                      en: "Contirm Password",
                                      mm: "စကားဝှက်ကို အတည်ပြုရန်",
                                      child: (pass) {
                                        return LocalizationWidget(
                                            en: "Please Fill The Confirm Password!",
                                            mm: "အတည်ပြုစကားဝှက်ကို ဖြည့်ပါ!",
                                            child: (fillPass) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: CustomTextFormField(
                                                  label: pass,
                                                  needBackground: true,
                                                  onSaved: () {},
                                                  onChanged: (val) {
                                                    registerBloc.add(
                                                        UpdateConfirmPasswordEvent(
                                                      context: context,
                                                      data: val,
                                                    ));
                                                  },
                                                  validator: (value) {
                                                    if (state.confirmPassword
                                                        .isEmpty) {
                                                      return fillPass;
                                                    }
                                                    return null;
                                                  },
                                                  pass: true,
                                                ),
                                              );
                                            });
                                      }),
                                  20.vertical,
                                  GestureDetector(
                                    onTap: () {
                                      if (state.sendStatus ==
                                          ApiStatus.completed) {
                                        registerBloc.add(ClickRegisteBtnEvent(
                                            context: context));
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
                                        en: " Sign Up",
                                        mm: "စာရင်းသွင်းပါ",
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
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 20.0,
                                        top: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LocalizationWidget(
                                                en: "Already Have an Account?",
                                                mm: "အကောင့်ရှိနှင့်ပြီးပြီလား?",
                                                child: (val) {
                                                  return RobotoText(
                                                      fontSize: 15.0,
                                                      fontColor: Colors.black,
                                                      text: val);
                                                }),
                                            InkWell(
                                              onTap: () {
                                                RouterService.of(context).pop();
                                              },
                                              child: LocalizationWidget(
                                                  en: "Sign in",
                                                  mm: "ဆိုင်းအင်လုပ်ခြင်း",
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

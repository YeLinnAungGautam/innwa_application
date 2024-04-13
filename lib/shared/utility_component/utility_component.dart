import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';

class UtilityComponent extends StatelessWidget {
  const UtilityComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.user != null)
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 15.0, top: 10.0, left: 20.0),
                child: InkWell(
                  onTap: () async {
                    Scaffold.of(context).closeDrawer();

                    RouterService.of(context)
                        .push(RouterPath.I.wishList.fullPath);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Icon(
                          FontAwesomeIcons.heart,
                          size: 18,
                        ),
                      ),
                      LocalizationWidget(
                          en: "Whishlist",
                          mm: "ဆန္ဒစာရင်း",
                          child: (val) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.black,
                                text: val,
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            if (state.user != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, left: 20.0),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    RouterService.of(context)
                        .push(RouterPath.I.orderHisotry.fullPath);
                  },
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.listUl,
                            size: 20,
                          )),
                      LocalizationWidget(
                          en: "My Order",
                          mm: "ကျွန်ုပ်ဧ။် အော်ဒါ",
                          child: (val) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.black,
                                text: val,
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            if (state.user != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, left: 20.0),
                child: InkWell(
                  onTap: () async {
                    Scaffold.of(context).closeDrawer();
                    await RouterService.of(context)
                        .push(RouterPath.I.services.fullPath);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Icon(Icons.settings),
                      ),
                      LocalizationWidget(
                          en: "Services",
                          mm: "ဝန်ဆောင်မှုများ",
                          child: (val) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.black,
                                text: val,
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 20.0),
              child: Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Icon(Icons.document_scanner),
                  ),
                  LocalizationWidget(
                      en: "Privacy Policy",
                      mm: "ကိုယ်ရေးအချက်အလက်မူဝါဒ",
                      child: (val) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RobotoText(
                            fontSize: 15.0,
                            fontColor: Colors.black,
                            text: val,
                          ),
                        );
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 20.0),
              child: Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Icon(Icons.document_scanner),
                  ),
                  LocalizationWidget(
                      en: "Terms & Conditions",
                      mm: "စည်းမျဉ်းများနဲ့အခြေအနေများ",
                      child: (val) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RobotoText(
                            fontSize: 15.0,
                            fontColor: Colors.black,
                            text: val,
                          ),
                        );
                      })
                ],
              ),
            ),
            if (state.user != null)
              LocalizationWidget(
                  en: "Are you sure to log out ?",
                  mm: "ထွက်ရန်သေချာပါသလား။",
                  child: (ask) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, left: 20.0),
                      child: InkWell(
                        onTap: state.logoutStatus != ApiStatus.processing
                            ? () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: RobotoText(
                                        fontSize: 14,
                                        fontColor: null,
                                        text: ask,
                                      ),
                                      actions: <Widget>[
                                        LocalizationWidget(
                                            en: "Close",
                                            mm: "ပိတ်",
                                            child: (val) {
                                              return TextButton(
                                                child: Text(val),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                            }),
                                        TextButton(
                                          child: LocalizationWidget(
                                              en: "Log out",
                                              mm: "ထွက်မည်",
                                              child: (val) {
                                                return Text(val);
                                              }),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            BlocProvider.of<UserBloc>(context)
                                                .add(LogoutEvent(
                                                    context: context));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            : null,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LocalizationWidget(
                                  en: "Log out",
                                  mm: "ထွက်မည်",
                                  child: (val) {
                                    return RobotoText(
                                      fontSize: 15.0,
                                      fontColor: Colors.red,
                                      text: state.logoutStatus !=
                                              ApiStatus.processing
                                          ? val
                                          : "Loading..",
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            if (state.user == null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, left: 20.0),
                child: InkWell(
                  onTap: () {
                    RouterService.of(context).push(RouterPath.I.login.fullPath);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Icon(Icons.login),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LocalizationWidget(
                            en: "Login",
                            mm: "လော့ဂ်အင်",
                            child: (val) {
                              return RobotoText(
                                fontSize: 15.0,
                                fontColor: Colors.black,
                                text: val,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}

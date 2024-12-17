import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:intl/intl.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(Icons.arrow_back_ios,
                                  color: Colors.black54),
                            ),
                            LocalizationWidget(
                                en: "My Account",
                                mm: "ကျွန်ုပ်ဧ။် အကောင့်",
                                child: (val) {
                                  return RobotoText(
                                    fontSize: 18.0,
                                    fontColor: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    text: val,
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LocalizationWidget(
                              en: "Profile",
                              mm: "ကိုယ်ရေးအကျဉ်း",
                              child: (val) {
                                return RobotoText(
                                  fontSize: 30.0,
                                  fontColor:
                                      Theme.of(context).colorScheme.primary,
                                  text: val,
                                  fontWeight: FontWeight.bold,
                                );
                              }),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                RouterService.of(context)
                                    .push(RouterPath.I.editProfile.fullPath);
                              },
                              child: LocalizationWidget(
                                en: "Edit Profile",
                                mm: "ကိုယ့်ရေးကိုယ်တာကိုပြုပြင်ရန်",
                                child: (val) {
                                  return RobotoText(
                                    fontSize: 15.0,
                                    fontColor:
                                        Theme.of(context).colorScheme.primary,
                                    text: val,
                                    fontWeight: FontWeight.w600,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onLongPress: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Version 1.4 build on Feb 4"),
                        ));
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: CachedNetworkImageProvider(state
                                    .user!.image ==
                                null
                            ? "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg"
                            : state.profileImagePath + state.user!.image!),
                      ),
                    ),
                    10.vertical,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LocalizationWidget(
                              en: "Name",
                              mm: "နာမည်",
                              child: (val) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  child: RobotoText(
                                    fontSize: 16.0,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    text: val,
                                  ),
                                );
                              }),
                          SizedBox(
                            width: 200,
                            child: RobotoText(
                              fontSize: 16.0,
                              fontColor: Colors.black,
                              text: state.user!.name,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LocalizationWidget(
                              en: "Email",
                              mm: "အီးမေးလ်",
                              child: (val) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  child: RobotoText(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.black,
                                    text: val,
                                  ),
                                );
                              }),
                          Container(
                            width: 200,
                            alignment: Alignment.centerLeft,
                            child: RobotoText(
                              fontSize: 16.0,
                              fontColor: Colors.black,
                              text: state.user!.email,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (state.user!.state != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LocalizationWidget(
                              en: "State",
                              mm: "ပြည်နယ်",
                              child: (val) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.21,
                                  child: RobotoText(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontColor: Colors.black,
                                    text: val,
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 200,
                              child: RobotoText(
                                fontSize: 16.0,
                                fontColor: Colors.black,
                                maxLine: 2,
                                text: state.user!.state!.enName,
                              ),
                            )
                          ],
                        ),
                      ),
                    if (state.user!.township != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LocalizationWidget(
                                en: "Township",
                                mm: "မြို့နယ်",
                                child: (val) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    child: RobotoText(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontColor: Colors.black,
                                      text: val,
                                    ),
                                  );
                                }),
                            SizedBox(
                              width: 200,
                              child: RobotoText(
                                fontSize: 16.0,
                                fontColor: Colors.black,
                                maxLine: 2,
                                text: state.user!.township!.enName,
                              ),
                            )
                          ],
                        ),
                      ),
                    if (state.user!.addressDetail != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LocalizationWidget(
                                en: "Address",
                                mm: "လိပ်စာ",
                                child: (val) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    child: RobotoText(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontColor: Colors.black,
                                      text: val,
                                    ),
                                  );
                                }),
                            SizedBox(
                              width: 200,
                              child: RobotoText(
                                fontSize: 16.0,
                                fontColor: Colors.black,
                                maxLine: 2,
                                text: "${state.user!.addressDetail}",
                              ),
                            )
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          LocalizationWidget(
                              en: "Registration Date",
                              mm: "မှတ်ပုံတင်ရက်",
                              child: (val) {
                                return RobotoText(
                                  fontSize: 15.0,
                                  fontColor: Colors.black,
                                  text: val,
                                  fontWeight: FontWeight.bold,
                                );
                              }),
                          10.vertical,
                          RobotoText(
                            fontSize: 12.0,
                            fontColor: Colors.black,
                            text: DateFormat.yMMMMd().format(
                              DateTime.parse(
                                state.user!.registeredAt ?? '',
                              ),
                            ),
                          )
                        ],
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
  }
}

// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/bloc/profile_edit_bloc.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/widgets/select_state_and_township.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileEditBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final ProfileEditBloc profileEditBloc =
            BlocProvider.of<ProfileEditBloc>(context)
              ..add(ProfileInitialEvent(context: context))
              ..add(GetStateEvent(context: context));
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return BlocBuilder<ProfileEditBloc, ProfileEditState>(
              builder: (context, profileState) {
                debugPrint(
                    "-----------Rebuild-----------------------------------------------------");
                return Scaffold(
                  body: Form(
                    key: profileEditBloc.updateForm,
                    child: CustomScrollView(
                      slivers: [
                        LocalizationWidget(
                            en: "Edit Profile",
                            mm: "ကိုယ့်ရေးကိုယ်တာကိုပြုပြင်ရန်",
                            child: (val) {
                              return SliverAppBar(
                                pinned: true,
                                centerTitle: false,
                                title: RobotoText(
                                  fontSize: 15,
                                  fontColor: null,
                                  text: val,
                                ),
                              );
                            }),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              if (profileState.selectedFile == null)
                                Container(
                                  child: GestureDetector(
                                    onLongPress: () {},
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        state.user!.image == null
                                            ? "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg"
                                            : state.profileImagePath +
                                                state.user!.image!,
                                      ),
                                    ),
                                  ),
                                ),
                              if (profileState.selectedFile != null)
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        profileState.selectedFile!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            profileEditBloc.add(ClearImageEvent(
                                                context: context));
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                        ))
                                  ],
                                ),
                              10.vertical,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      profileEditBloc.add(
                                          GetImageFromGalleryEvent(
                                              context: context));
                                    },
                                    child: LocalizationWidget(
                                        en: "Gallery",
                                        mm: "ပြခန်း",
                                        child: (val) {
                                          return RobotoText(
                                            fontSize: 15,
                                            fontColor: null,
                                            text: val,
                                          );
                                        }),
                                  ),
                                  20.horizontal,
                                  ElevatedButton(
                                    onPressed: () {
                                      profileEditBloc.add(
                                          GetImageFromCameraEvent(
                                              context: context));
                                    },
                                    child: LocalizationWidget(
                                        en: "Camera",
                                        mm: "ကင်မရာ",
                                        child: (val) {
                                          return RobotoText(
                                            fontSize: 15,
                                            fontColor: null,
                                            text: val,
                                          );
                                        }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: 20.vertical,
                        ),
                        SliverToBoxAdapter(
                          child: LocalizationWidget(
                              en: "Your Email Is Invalid!",
                              mm: "သင့်အီးမေးလ်သည် မမှန်ကန်ပါ။",
                              child: (invalidMail) {
                                return LocalizationWidget(
                                    en: "Please Fill The Email !",
                                    mm: "ကျေးဇူးပြုပြီး အီးမေးလ် ဖြည့်ပါ!",
                                    child: (pleaseFill) {
                                      return LocalizationWidget(
                                          en: "Email",
                                          mm: "အီးမေးလ်",
                                          child: (val) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: TextFormField(
                                                controller: profileEditBloc
                                                    .emailController,
                                                decoration: InputDecoration(
                                                  label: Text(val),
                                                ),
                                                validator: (val) {
                                                  final RegExp emailRegex = RegExp(
                                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                                  if (val!.isEmpty) {
                                                    return pleaseFill;
                                                  } else if (!emailRegex
                                                      .hasMatch(val)) {
                                                    return invalidMail;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            );
                                          });
                                    });
                              }),
                        ),
                        SliverToBoxAdapter(
                          child: LocalizationWidget(
                              en: "Please Fill The Name !",
                              mm: "ကျေးဇူးပြုပြီး နာမည်ဖြည့်ပေးပါ!",
                              child: (fillName) {
                                return LocalizationWidget(
                                    en: "Name",
                                    mm: "နာမည်",
                                    child: (name) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: TextFormField(
                                          controller:
                                              profileEditBloc.nameController,
                                          decoration: InputDecoration(
                                            label: Text(name),
                                          ),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return fillName;
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    });
                              }),
                        ),
                        SliverToBoxAdapter(
                          child: LocalizationWidget(
                              en: "Please Fill The Address !",
                              mm: "လိပ်စာလေးဖြည့်ပေးပါ!",
                              child: (fillAddress) {
                                return LocalizationWidget(
                                    en: "Address",
                                    mm: "လိပ်စာ",
                                    child: (address) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: TextFormField(
                                          controller:
                                              profileEditBloc.addressController,
                                          maxLines: 3,
                                          minLines: 3,
                                          decoration: InputDecoration(
                                            label: Text(address),
                                          ),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return fillAddress;
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    });
                              }),
                        ),
                        SliverToBoxAdapter(
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
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0),
                                                    child: TextFormField(
                                                      controller:
                                                          profileEditBloc
                                                              .phoneController,
                                                      decoration:
                                                          InputDecoration(
                                                        label: Text(phone),
                                                        prefix:
                                                            const Text("09"),
                                                      ),
                                                      validator: (value) {
                                                        if (value != null &&
                                                            value.isEmpty) {
                                                          return fillPhone;
                                                        } else if (value !=
                                                                null &&
                                                            value.isNotEmpty) {
                                                          if (value.length <=
                                                              6) {
                                                            return atLeastSeven;
                                                          }
                                                          if (value.length >
                                                              9) {
                                                            return atLeastEight;
                                                          }
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  );
                                                });
                                          });
                                    });
                              }),
                        
                        ),
                        SliverToBoxAdapter(
                          child: 10.vertical,
                        ),
                        const SliverToBoxAdapter(
                          child: SelectStateAndTownship(),
                        ),
                        SliverToBoxAdapter(
                          child: 20.vertical,
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:
                                BlocBuilder<ProfileEditBloc, ProfileEditState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state.sendStatus ==
                                          ApiStatus.processing
                                      ? null
                                      : () {
                                          profileEditBloc.add(UpdateFormEvent(
                                              context: context));
                                        },
                                  child: LocalizationWidget(
                                      en: "Update",
                                      mm: "",
                                      child: (context) {
                                        return Text(state.sendStatus ==
                                                ApiStatus.processing
                                            ? "Loading.."
                                            : 'မြှင့်တင်မည်');
                                      }),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

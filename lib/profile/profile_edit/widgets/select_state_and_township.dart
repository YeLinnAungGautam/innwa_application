import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/bloc/profile_edit_bloc.dart';

class SelectStateAndTownship extends StatelessWidget {
  const SelectStateAndTownship({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
      builder: (context, state) {
        final ProfileEditBloc profileEditBloc = BlocProvider.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalizationWidget(
                      en: "Select State",
                      mm: "ပြည်နယ်ရွေးပါ",
                      child: (val) {
                        return Text(val);
                      }),
                  10.vertical,
                  GestureDetector(
                    onTap: () {
                      if (state.stateGetState == ApiStatus.failure) {
                        profileEditBloc.add(GetStateEvent(context: context));
                      } else {
                        if (state.stateGetState == ApiStatus.completed) {
                          profileEditBloc.add(
                              ShowStateBotttomSheetEvent(context: context));
                        }
                      }
                    },
                    child: LocalizationWidget(
                        en: "Select State",
                        mm: "ပြည်နယ်ကို ရွေးပါ။",
                        child: (select) {
                          return LocalizationWidget(
                              en: "Retry!",
                              mm: "ထပ်စမ်းပါ!",
                              child: (retry) {
                                return LocalizationWidget(
                                    en: state.selectedState?.enName,
                                    mm: state.selectedState?.mmName,
                                    child: (val) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 6),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(state.selectedState == null
                                            ? (state.stateGetState ==
                                                    ApiStatus.processing
                                                ? "Loading"
                                                : state.stateGetState ==
                                                        ApiStatus.failure
                                                    ? retry
                                                    : select)
                                            : val),
                                      );
                                    });
                              });
                        }),
                  ),
                ],
              ),
              30.horizontal,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalizationWidget(
                      en: "Select Township",
                      mm: "မြို့နယ်ရွေး",
                      child: (val) {
                        return Text(val);
                      }),
                  10.vertical,
                  GestureDetector(
                    onTap: () {
                      if (state.townshipGetState == ApiStatus.failure) {
                        profileEditBloc.add(GetStateEvent(context: context));
                      } else {
                        if (state.selectedState != null &&
                            state.townshipGetState == ApiStatus.completed) {
                          profileEditBloc.add(
                              ShowTownshipBottomsheetEvent(context: context));
                        }
                      }
                    },
                    child: LocalizationWidget(
                        en: "Select Township",
                        mm: "မြို့နယ်ရွေး",
                        child: (selectTownShip) {
                          return LocalizationWidget(
                              en: state.selectedTownship?.enName,
                              mm: state.selectedTownship?.mmName,
                              child: (township) {
                                return LocalizationWidget(
                                    en: "Retry!",
                                    mm: "ထပ်စမ်းပါ!",
                                    child: (retry) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 6),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          state.selectedTownship == null
                                              ? (state.townshipGetState ==
                                                      ApiStatus.processing
                                                  ? "Loading"
                                                  : state.townshipGetState ==
                                                          ApiStatus.failure
                                                      ? retry
                                                      : selectTownShip)
                                              : township,
                                        ),
                                      );
                                    });
                              });
                        }),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

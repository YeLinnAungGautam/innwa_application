import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/profile/profile_edit/bloc/profile_edit_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class SelectTownshipUi extends StatelessWidget {
  const SelectTownshipUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              LocalizationWidget(
                  en: "Select Township",
                  mm: "မြို့နယ်ရွေး",
                  child: (val) {
                    return SliverAppBar(
                      pinned: true,
                      title: Text(val),
                    );
                  }),
              SliverToBoxAdapter(
                child: 15.vertical,
              ),
              SliverList.builder(
                  itemCount: state.townships.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<ProfileEditBloc>(context).add(
                          UpdateSelectedTownshipEvent(
                            context: context,
                            data: state.townships[index],
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LocalizationWidget(
                                en: state.townships[index].enName,
                                mm: state.townships[index].mmName,
                                child: (val) {
                                  return RobotoText(
                                    fontSize: 14,
                                    fontColor: null,
                                    text: val,
                                  );
                                }),
                            if (state.selectedTownship?.id ==
                                state.townships[index].id)
                              const Icon(Icons.check),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}

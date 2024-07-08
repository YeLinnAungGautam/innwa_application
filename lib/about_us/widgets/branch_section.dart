import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/about_us/bloc/about_us_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/ui/error_retry.dart';

import 'branches_widget.dart';

class BranchSection extends StatelessWidget {
  const BranchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutUsBloc, AboutUsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocalizationWidget(
              en: "Branches",
              mm: "ဆိုင်ခွဲများ",
              child: (val) {
                return RobotoText(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontColor: null,
                  text: val,
                );
              },
            ),
            15.vertical,
            if (state.branchStatus == ApiStatus.processing)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (state.branchStatus == ApiStatus.failure)
              Center(
                child: ErrorRetry(
                  retryFun: () {
                    BlocProvider.of<AboutUsBloc>(context)
                        .add(GetBranchEvent(context: context));
                  },
                ),
              ),
            if (state.branchStatus == ApiStatus.completed)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...state.branches
                      .map((branch) => BranchesWidget(
                            branches: branch,
                          ))
                      ,
                ],
              )
          ],
        );
      },
    );
  }
}


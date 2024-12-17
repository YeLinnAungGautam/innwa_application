import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';

import '../../_application/service/localization/loclaization_view.dart';
import '../../shared/texts/roboto_text/roboto_text.dart';
import '../model/branch_model.dart';
import 'branch_card.dart';

class BranchesWidget extends StatelessWidget {
  const BranchesWidget({super.key, required this.branches});

  final BranchModel branches;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocalizationWidget(
            en: branches.enName,
            mm: branches.mmName,
            child: (val) {
              return RobotoText(
                fontSize: 18,
                fontColor: null,
                text: val,
                fontWeight: FontWeight.bold,
              );
            },
          ),
          12.vertical,
          SizedBox(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: branches.branch.length,
              itemBuilder: (context, index) {
                return BranchCard(branch: branches.branch[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

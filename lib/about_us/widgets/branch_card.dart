import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

import '../../_application/service/localization/loclaization_view.dart';
import '../../constant/api_constant.dart';
import '../model/branch_model.dart';

class BranchCard extends StatelessWidget {
  final SubBranchModel branch;

  const BranchCard({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Card(
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: "$kBranchesImageBaseUrl${branch.image ?? ''}",
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.cover,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalizationWidget(
                    en: branch.enName,
                    mm: (branch.mmName == null && branch.mmName == "null")
                        ? "Not Available"
                        : branch.mmName,
                    child: (val) {
                      return RobotoText(
                        fontSize: 17,
                        fontColor: null,
                        text: val,
                        fontWeight: FontWeight.bold,
                      );
                    },
                  ),
                  10.vertical,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_pin),
                      8.horizontal,
                      Flexible(
                        child: LocalizationWidget(
                          en: branch.enAddress,
                          mm: (branch.mmAddress == null &&
                                  branch.mmAddress == "null")
                              ? "Not Available"
                              : branch.mmAddress,
                          child: (val) {
                            return RobotoText(
                              fontSize: 14,
                              fontColor: null,
                              text: val,
                              maxLine: 3,
                              fontWeight: FontWeight.w600,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  12.vertical,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.phone),
                      8.horizontal,
                      Flexible(
                        child: RobotoText(
                          fontSize: 14,
                          fontColor: null,
                          fontWeight: FontWeight.w600,
                          maxLine: 2,
                          text: branch.phone,
                        ),
                      )
                    ],
                  ),
                  12.vertical,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.headset_mic),
                      8.horizontal,
                      Flexible(

                        child: RobotoText(
                          fontSize: 14,
                          fontColor: null,
                          fontWeight: FontWeight.w600,
                          maxLine: 2,
                          text: branch.servicePhone,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

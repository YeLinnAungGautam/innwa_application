import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ViewMorePromotion extends StatelessWidget {
  const ViewMorePromotion({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 200,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LocalizationWidget(
                en: "View More",
                mm: "ပိုမိုကြည့်ရှုရန်",
                child: (val) {
                  return RobotoText(
                    fontSize: 18,
                    fontColor: null,
                    fontWeight: FontWeight.bold,
                    text: val,
                  );
                },
              ),
              10.horizontal,
              const Icon(
                CupertinoIcons.arrow_right_circle_fill,
                color: Colors.black,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

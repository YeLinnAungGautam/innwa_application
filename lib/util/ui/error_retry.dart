import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ErrorRetry extends StatelessWidget {
  const ErrorRetry({this.label, required this.retryFun, super.key});
  final String? label;
  final VoidCallback retryFun;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          Assets.images.warning.path,
          width: 80,
          height: 80,
          color: Colors.red,
        ),
        15.vertical,
        RobotoText(
          fontSize: 20,
          fontColor: Colors.red,
          text: label ?? "Something went wrong!",
          fontWeight: FontWeight.bold,
        ),
        30.vertical,
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: () {
            retryFun.call();
          },
          child: const Text('Retry!'),
        )
      ],
    );
  }
}

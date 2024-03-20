import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';

class InnwaError extends StatelessWidget {
  const InnwaError({required this.onClick, super.key});
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          Assets.images.noInternet.path,
          width: 100,
          height: 100,
        ),
        20.vertical,
        ElevatedButton(
          onPressed: onClick,
          child: const Text("Retry!"),
        ),
      ],
    );
  }
}

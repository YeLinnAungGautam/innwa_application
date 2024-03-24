import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/router_service/router.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RouterService.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.chevron_left,
        ),
      ),
    );
  }
}

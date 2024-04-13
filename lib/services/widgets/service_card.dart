import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';
import 'package:innwa_mobile_dev/services/model/service_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({required this.service, this.isActive = false, super.key});
  final ServiceModel service;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isActive
          ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.settings.path,
            width: 30,
            height: 30,
          ),
          15.vertical,
          RobotoText(
            fontSize: 15,
            fontColor: isActive ? Colors.white : null,
            text: service.enName,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}

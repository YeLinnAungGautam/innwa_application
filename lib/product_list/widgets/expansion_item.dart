import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ExpansionItem extends StatelessWidget {
  const ExpansionItem({
    required this.label,
    required this.isActive,
    this.colorCode,
    super.key,
  });
  final String label;
  final bool isActive;
  final String? colorCode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: RobotoText(
                      fontSize: 15,
                      fontColor: null,
                      text: label,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              if (isActive)
                Icon(
                  Icons.check,
                  size: 15,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

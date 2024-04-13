import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {required this.isHistory,
      required this.orderNo,
      required this.subTotal,
      this.orderStatus,
      super.key});
  final bool isHistory;
  final String orderNo;
  final int subTotal;
  final String? orderStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 125,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            spreadRadius: -3,
            blurRadius: 8,
            color: Color.fromRGBO(225, 225, 225, 1),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            isHistory
                ? Assets.images.orderDelivery.path
                : Assets.images.file.path,
            width: 70,
            height: 70,
            color: Theme.of(context).colorScheme.primary,
          ),
          12.horizontal,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: orderStatus == null
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.4,
                    child: RobotoText(
                      fontSize: 16,
                      fontColor: null,
                      text: orderNo,
                      maxLine: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  10.vertical,
                  RobotoText(
                      fontSize: 14, fontColor: null, text: "$subTotal MMK"),
                ],
              ),
              if (orderStatus != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RobotoText(
                      fontSize: 14,
                      fontColor: null,
                      text: "status",
                    ),
                    7.vertical,
                    RobotoText(
                      fontSize: 13,
                      fontColor: Colors.amber.shade700,
                      text: "$orderStatus",
                    ),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';
import 'package:innwa_mobile_dev/order/order_history/helpers/status_helpers.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {required this.isHistory,
      required this.orderNo,
      required this.subTotal,
      this.orderStatus,
      super.key,
      this.onTap,
      this.paymentStatus});

  final bool isHistory;
  final String orderNo;
  final int subTotal;
  final String? orderStatus;
  final String? paymentStatus;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    OrderStatus ordStatus = OrderStatus.orderStatusType(text: orderStatus);
    PaymentStatus payStatus =
        PaymentStatus.paymentStatusType(text: paymentStatus);

    final String statusStr = isHistory
        ? OrderStatus.values
            .where((orderStatus) => orderStatus == ordStatus)
            .map((e) => e.orderStatus)
            .first
        : PaymentStatus.values
            .where((pStatus) => pStatus == payStatus)
            .map((e) => e.paymentStatus)
            .first;

    final Color statusClr = isHistory
        ? OrderStatus.values
            .where((orderStatus) => orderStatus == ordStatus)
            .map((e) => e.color)
            .first
        : PaymentStatus.values
            .where((pStatus) => pStatus == payStatus)
            .map((e) => e.color)
            .first;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !isHistory && ordStatus != OrderStatus.invalid
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: OrderStatus.values
                          .where((orderStatus) => orderStatus == ordStatus)
                          .map((e) => e.color)
                          .first,
                    ),
                    5.horizontal,
                    RobotoText(
                      fontSize: 14,
                      fontColor: Colors.black54,
                      text: OrderStatus.values
                          .where((orderStatus) => orderStatus == ordStatus)
                          .map((e) => e.orderStatus)
                          .first,
                    )
                  ],
                )
              : const SizedBox.shrink(),
          5.vertical,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: Image.asset(
                  isHistory
                      ? Assets.images.orderDelivery.path
                      : Assets.images.file.path,
                  width: 60,
                  height: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RobotoText(
                    fontSize: 14,
                    fontColor: Colors.black87,
                    text: "#ORD# $orderNo",
                    fontWeight: FontWeight.w600,
                  ),
                  5.vertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RobotoText(
                        fontSize: 14,
                        fontColor: null,
                        text: isHistory ? "Order Status" : "Payment status",
                      ),
                      10.horizontal,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: statusClr,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RobotoText(
                          fontSize: 10,
                          fontColor: Colors.white,
                          text: statusStr,
                        ),
                      )
                    ],
                  ),
                  5.vertical,
                  RobotoText(
                    fontSize: 14,
                    fontColor: null,
                    text: "$subTotal MMK",
                  ),
                ],
              ),
              // if (orderStatus != null)
              //   Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       RobotoText(
              //         fontSize: 14,
              //         fontColor: null,
              //         text: "status",
              //       ),
              //       7.vertical,
              //       RobotoText(
              //         fontSize: 13,
              //         fontColor: Colors.amber.shade700,
              //         text: "$orderStatus",
              //       ),
              //     ],
              //   )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/order/order.dart';
import 'package:innwa_mobile_dev/screen/order_status/order_history.dart';
import 'package:innwa_mobile_dev/screen/order_status/order_pending.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class OrderType extends StatefulWidget {
  const OrderType({super.key});

  @override
  State<OrderType> createState() => _OrderTypeState();
}

class _OrderTypeState extends State<OrderType> {
  bool isHistory = true;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  isHistory = true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isHistory ? Colors.indigo : Colors.transparent,
                    border: Border.all(width: 1,color: Colors.grey)
                    
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 30.0,right: 30.0),
                    child: RobotoText(fontSize: 18.0, fontColor: isHistory ? Colors.white : Colors.black, text: "History"),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  isHistory = false;
                });
              } ,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: isHistory ?   Colors.transparent : Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1,color: Colors.grey)
                    
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 30.0,right: 30.0),
                    child: RobotoText(fontSize: 18.0, fontColor: isHistory ? Colors.indigo : Colors.white, text: "Pending"),
                  ),
                ),
              ),
            )
          ],
        ),
        isHistory ?
         OrderHistory()
        :
        OrderPending()
      ],
    );
  }
}
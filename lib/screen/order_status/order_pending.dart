import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/order_status/components/pendingt_cart_items.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class OrderPending extends StatelessWidget {
  const OrderPending({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height/1.4,
        child: Column(
          children: [   
                     
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.4,
              child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left : 8.0),
                      child: RobotoText(fontSize: 18.0, fontColor: Colors.black, text: "27 Oct 2022"),
                    ),
                    PendingCartItem(isDelete: false,)
                  ],
                );
              },
              ),
            )
          ],
        ),
      );
    
  }
}
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/cart/components/cart_item.dart';
import 'package:innwa_mobile_dev/util/constants.dart';


class CartLists extends StatelessWidget {
  const CartLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/1.45,
     
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CartItem(isDelete: true,isItemContorl: true,isOrderHistory: false,);
        },
      ),
    );
  }
}
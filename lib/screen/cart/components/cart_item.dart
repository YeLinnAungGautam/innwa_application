import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/cart/components/item_control.dart';
import 'package:innwa_mobile_dev/shared/avatar/avatar.dart';
import 'package:innwa_mobile_dev/shared/image_container/image_container.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class CartItem extends StatefulWidget {
  bool isDelete;
  bool isItemContorl;
  bool isOrderHistory;
  CartItem(
      {super.key,
      required this.isDelete,
      required this.isItemContorl,
      required this.isOrderHistory});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int originalPrice = 10000;
  int amount = 10000;
  void updateQTY() {
    setState(() {
      amount += originalPrice;
    });
  }

  void reduceQTY() {
    setState(() {
      amount -= originalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            spreadRadius: -3,
            blurRadius: 8,
            color: Color.fromRGBO(225, 225, 225, 1),
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ImageContainer(
                  width: 70.0,
                  height: 70.0,
                  url:
                      "https://innwa.com.mm/images/products/smartphone/samsung/64c1f2e089e5d/64c1f2e089e5dsamsung-z-fold-5.png",
                  isUrl: true,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RobotoText(
                    fontSize: 16.0,
                    fontColor: Colors.black,
                    text: "Azus ROG PUGIO Mouse"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RobotoText(
                      fontSize: 15.0,
                      fontColor: Colors.black54,
                      text: amount.toString() + " MMK"),
                ),
                !widget.isOrderHistory
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RobotoText(
                            fontSize: 13.0,
                            fontColor: Colors.black54,
                            text: "total : 210,000 MMK"),
                      )
                    : SizedBox()
              ],
            ),
            widget.isItemContorl
                ? ItemCountrol(
                    updateQty: updateQTY,
                    reduceQty: reduceQTY,
                  )
                : SizedBox(),
            widget.isDelete
                ? Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 30,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

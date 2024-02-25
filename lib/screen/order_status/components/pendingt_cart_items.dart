import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/avatar/avatar.dart';
import 'package:innwa_mobile_dev/shared/image_container/image_container.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class PendingCartItem extends StatelessWidget {
  bool isDelete;
  PendingCartItem({super.key, required this.isDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            spreadRadius: -3,
            blurRadius: 8,
            color: Color.fromRGBO(207, 207, 207, 1),
          )
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ImageContainer(
                 isUrl: true,
                  url:
                      "https://innwa.com.mm/images/products/smartphone/nokia/63414a52348fc/63414a52348fcnokia105.jpg",
                  width: 70.0,
                  height: 70.0),
            ),
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
                      text: "105,000 MMK"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RobotoText(
                      fontSize: 13.0,
                      fontColor: Color.fromRGBO(226, 176, 48, 1),
                      text: "Order Status : Pending"),
                ),
              ],
            ),
            // ItemCountrol(),

            isDelete
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

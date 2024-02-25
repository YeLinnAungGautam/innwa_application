import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/cart/cart.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';


class PriceConfirm extends StatelessWidget {
  const PriceConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.only(top:20.0, bottom: 20.0),
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.price_change_outlined),
                  RobotoText(
                      fontSize: 30.0, fontColor: Colors.indigo[700], text: "120,000",fontWeight: FontWeight.w800,)
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Cart())),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(231, 236, 240,1),
                  ),
                  child: Center(child: RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Confirm",fontWeight: FontWeight.w700,)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

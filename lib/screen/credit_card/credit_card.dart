import 'dart:math';

import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';


class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> images = ["assets/images/worldtravel.jpg","assets/images/worldmap.jpg","assets/images/shopping.jpg"];
    var rng = Random();
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
            Container(
              width: 300,
              height: 130,
              
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(images[rng.nextInt(3)]),
                  fit: BoxFit.cover,
                  opacity: 0.15
                )
                ,
                  color: Colors.indigo, borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RobotoText(fontSize: 18.0, fontColor: Colors.black, text: "VISA"),
                      )
                    ],
                  ),
          
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RobotoText(
                            fontSize: 18.0,
                            fontColor: Colors.white,
                            text: "Takina Inoue".toUpperCase()),
                  
                         RobotoText(
                        fontSize: 15.0,
                        fontColor: Colors.white,
                        text: "EXP : 12/23")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RobotoText(
                        fontSize: 18.0,
                        fontColor: Colors.white,
                        text: "**** **** **** 2134"),
                  ),
          
                     
                ],
              ),
            )
                ],
              ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text_padding.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class Specification extends StatelessWidget {
  const Specification({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10.0))
          ),

          
          child: Column(
            children: [
                Icon(Icons.minimize_rounded,color: Colors.black,size: 40,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,bottom: 10.0),
                      child: RobotoText(
                          fontSize: 16.0,
                          fontColor: Colors.black,
                          text: "Specifications",
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          RobotoTextPadding(padding: 4, fontSize: 15.0, fontColor: Colors.black ,text: "CPU",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Memory",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Storage",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Graphic",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Drive",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Security",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Dsiplay",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Color",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Warranty",fontWeight: FontWeight.bold),
                          RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Features",fontWeight: FontWeight.bold),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "AMD Ryzen 5 5000 U"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "8GB DDR4"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "512GB SSD M.2 2242 PCIE"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "AMD Radeon Graphic"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "No DVD Drive"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Finger Print"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "14'' FHD IPS, 250 nits AG"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Black"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "1 Year"),
                        RobotoTextPadding(padding: 4,fontSize: 15.0, fontColor: Colors.black, text: "Fingerprint,Backlit"),
                      ],
                    )
                  ],
                )
            ],
          ),
        )
      ],
    );
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/bottom_sheet/bottom_sheet.dart';


class AddToCard extends StatelessWidget {
  double width;
  double height;
  AddToCard({super.key,required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8.0),
          child: OutlinedButton(
            
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                side: BorderSide(width: 1,color: Colors.grey),
                fixedSize: Size(width, height),
                backgroundColor: Colors.white, //<-- SEE HERE
              ),
              onPressed: () {

                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  
                  context: context, builder: (context){
                  return CustomBottomSheet(text: "Lenovo Think Pad",isPromo: false,);
                    },
                  );
                }

              ,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_sharp,color: Colors.black,size: 17.0,),
                  Padding(
                    padding: EdgeInsets.only(left:3.0),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 14.0,color: Colors.black),
                    ),
                  ),
                ],
              )),
        );
      }
    );
  }
}



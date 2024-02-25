import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/stars.dart';
import 'package:innwa_mobile_dev/shared/avatar/avatar.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230.0,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_3_outlined),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RobotoText(
                                    fontSize: 15.0,
                                    fontColor: Colors.black,
                                    text: "Kyaw Kyaw",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Stars(count: 3)
                                ],
                              ),
                            )
                          ],
                        ),
                        
                      ],
                    ),
                    
                  ),
            
                     Padding(
                    padding: const EdgeInsets.only(left: 40.0,bottom: 5.0),
                    child: RobotoText(fontSize: 14.0, fontColor: Colors.black, text: "I love this product"),
                  ),
                 
                  
                  
                  
                ],
              ),
            );
          }),
    );
  }
}

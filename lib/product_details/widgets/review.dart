import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:innwa_mobile_dev/shared/custom_text_field/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColorLight,
            borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RobotoText(
                  fontSize: 18,
                  fontColor: Colors.black,
                  text: "What do you think of this product?",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RobotoText(
                    fontSize: 20.0,
                    fontColor: Colors.black,
                    text: "4.5",
                    fontWeight: FontWeight.w700,
                  ),
                  RatingBar.builder(
                    itemSize: 30,
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,                      
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
              // CustomTextFormField(onSaved: ()=>{}, label: "Write your review ....", pass: false, needBackground: true),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Write your review",
                      hintStyle: TextStyle(fontFamily: "SanFrancisco",fontSize: 15.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Colors.black54), //<-- SEE HERE
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Colors.black54), //<-- SEE HERE
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

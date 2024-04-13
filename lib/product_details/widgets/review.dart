import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return LocalizationWidget(
            en: "What do you think of this product?",
            mm: "ဒီပစ္စည်းကို ဘယ်လိုထင်လဲ။",
            child: (whatDoYouThink) {
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
                            text: whatDoYouThink,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RobotoText(
                              fontSize: 20.0,
                              fontColor: Colors.black,
                              text: state.rating.toString().split(".")[0],
                              fontWeight: FontWeight.w700,
                            ),
                            RatingBar.builder(
                              itemSize: 30,
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                BlocProvider.of<ProductDetailsBloc>(context)
                                    .add(UpdateRatingEvent(
                                        context: context, rating: rating));
                              },
                            ),
                          ],
                        ),
                        // CustomTextFormField(onSaved: ()=>{}, label: "Write your review ....", pass: false, needBackground: true),

                        LocalizationWidget(
                            en: "Write your review",
                            mm: "သင်၏သုံးသပ်ချက်ကိုရေးပါ။",
                            child: (write) {
                              return LocalizationWidget(
                                  mm: "ဤအကွက်ကို ဖြည့်ပါ။",
                                  en: "Please Fill This Field!",
                                  child: (pleaseFill) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        child: Form(
                                          key: BlocProvider.of<
                                                  ProductDetailsBloc>(context)
                                              .ratingForm,
                                          child: TextFormField(
                                            maxLines: 2,
                                            controller: BlocProvider.of<
                                                    ProductDetailsBloc>(context)
                                                .ratingTextController,
                                            validator: (val) {
                                              if (val != null && val.isEmpty) {
                                                return pleaseFill;
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: write,
                                              hintStyle: const TextStyle(
                                                  fontFamily: "SanFrancisco",
                                                  fontSize: 15.0),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors
                                                        .black54), //<-- SEE HERE
                                              ),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Colors
                                                        .black54), //<-- SEE HERE
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LocalizationWidget(
                                en: "Add Review",
                                mm: "သုံးသပ်ချက်ထည့်ပါ။",
                                child: (addReview) {
                                  return ElevatedButton(
                                    onPressed: state.ratingAddStatus ==
                                            ApiStatus.processing
                                        ? null
                                        : () {
                                            BlocProvider.of<ProductDetailsBloc>(
                                                    context)
                                                .add(ClickAddReviewEvent(
                                                    context: context));
                                          },
                                    child: Text(addReview),
                                  );
                                })
                          ],
                        ),
                        10.vertical,
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

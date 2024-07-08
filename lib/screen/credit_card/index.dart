import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/screen/credit_card/credit_card.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/1.5,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const CreditCard();
              },
              ),
          ),

          GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          'Add Card',
                          style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                    ),
        ],
      )
    );
  }
}
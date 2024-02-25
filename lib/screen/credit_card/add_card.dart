import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/screen/auth/components/custom_text_form_field.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';


class AddCard extends StatefulWidget {
  final String text;
  AddCard({super.key,required this.text});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String name = '';
  String cardNumber = '';
  String exp = '';
  String cvv = '';

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success or Fail Message'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('After User paid, it will return to My Order Page'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/worldtravel.jpg",
      "assets/images/worldmap.jpg",
      "assets/images/shopping.jpg"
    ];
    var rng = Random();
    return 
        Container(
          color: backgroundColorLight,
          child: SafeArea(
            child: Scaffold(
              appBar: TopBar(needBackButton: true,needMenu: false,title: widget.text,),
              drawer: CustomDrawerWidget(onDrawerTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
                       
                      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                        currentFocus.unfocus();
                      }
          }),
              body: Column(
                children: [
                  
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            height: 170,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(images[0]),
                                    fit: BoxFit.cover,
                                    opacity: 0.15),
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RobotoText(fontColor: Colors.black,fontSize: 18.0,text: widget.text.toUpperCase(),),
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
                                          text: name.toUpperCase()),
                                      RobotoText(
                                          fontSize: 15.0,
                                          fontColor: Colors.white,
                                          text: "EXP : "+exp)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RobotoText(
                                      fontSize: 18.0,
                                      fontColor: Colors.white,
                                      text: cardNumber),
                                ),
                            
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RobotoText(
                                      fontSize: 18.0,
                                      fontColor: Colors.white,
                                      text: cvv),
                                ),
                              ],
                            ),
                          ),
                          CustomTextFormField(
                              onSaved: () {},
                              onChanged: (value) {
                                setState(() {
                                  cardNumber = value;
                                });
                              },
                              label: "Card Number",
                              pass: false,
                              needBackground: true),
                          CustomTextFormField(
                              onSaved: () {},
                              label: "Card Holder Name",
                              onChanged: (value){
                                setState(() {
                                  name = value;
                                });
                              },
                              pass: false,
                              needBackground: true),
                          CustomTextFormField(
                              onSaved: () {},
                              label: "Expiration Date",
                              onChanged: (value){
                                setState(() {
                                  exp = value;
                                });
                              },
                              pass: false,
                              needBackground: true),
                          CustomTextFormField(
                              onSaved: () {},
                              label: "CVV",
                              onChanged: (value){
                                setState(() {
                                  cvv = value;
                                });
                              },
                              pass: false,
                              needBackground: true),
                            
                          GestureDetector(
                                    onTap: () {
                                      _showMyDialog();
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: primaryColor,
                                      ),
                                      child: Center(
                                          child: Text(
                                        'PAY',
                                        style: GoogleFonts.roboto(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                        ],
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:innwa_mobile_dev/screen/auth/authentication.dart';
import 'package:innwa_mobile_dev/screen/order_status/order_status.dart';
import 'package:innwa_mobile_dev/screen/profile/profile.dart';
import 'package:innwa_mobile_dev/screen/wishlist/whishlist.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class UtilityComponent extends StatelessWidget {
  const UtilityComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom:15.0,top: 10.0,left: 20.0),
          child: InkWell(
            onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  WishList())),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: Icon(FontAwesomeIcons.heart,size: 18,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Whishlist"),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom:15.0,left: 20.0),
          child: InkWell(
            onTap: (){
            Scaffold.of(context).closeDrawer();
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  OrderStatus()));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(FontAwesomeIcons.listUl,size: 20,)
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "My Order"),
                )
              ],
            ),
          ),
        ) ,
         Padding(
          padding: const EdgeInsets.only(bottom:15.0,left: 20.0),
          child: InkWell(
            onTap: (){
            Scaffold.of(context).closeDrawer();
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  Profile()));
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: Icon(Icons.settings),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Account Setting"),
                )
              ],
            ),
          ),
        ) ,
        Padding(
          padding: const EdgeInsets.only(bottom :15.0,left: 20.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                child: Icon(Icons.document_scanner),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Privacy Policy"),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom : 15.0,left: 20.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                child: Icon(Icons.document_scanner),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Terms & Conditions"),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom : 15.0,left: 20.0),
          child: InkWell(
            onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  Authentication())),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: Icon(Icons.login),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Login"),
                )
              ],
            ),
          ),
        )   
      ],
    );
  }
}
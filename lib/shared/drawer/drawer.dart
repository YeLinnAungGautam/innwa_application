import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/profile/profile.dart';
import 'package:innwa_mobile_dev/shared/avatar/avatar.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/utility_component/utility_component.dart';
import 'package:innwa_mobile_dev/util/constants.dart';


class CustomDrawerWidget extends StatelessWidget {
  final VoidCallback onDrawerTap;
  const CustomDrawerWidget({super.key,required this.onDrawerTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  () {
                FocusScope.of(context).unfocus();
              },
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width/1.3,
          color: backgroundColorLight,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: logoImage(),
                    ),
                    InkWell(
                      onTap: () => Scaffold.of(context).closeDrawer(),
                      child: Icon(Icons.menu_open,size: 30,))
                  ],
                ),
              ),
          
              InkWell(
                onTap: () =>Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile())),
                child: Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left : 10.0),
                        child: Avatar(
                            image:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp2lasl_QjsB0vVpouDq_SQz3yPQrnwC0W9w&usqp=CAU",
                            width: 60,
                            height: 60),
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RobotoText(fontSize: 18.0, fontColor: Colors.black87, text: "Takina Inoue",fontWeight: FontWeight.bold),
                           Container(
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(20)
              
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 15.0,right: 15.0),
                              child: RobotoText(fontSize: 12.0, fontColor: Colors.white, text: "ID:123123123"),
                            ),
                           )
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,size: 18.0,)
                    ],
                  ),
                ),
              ),
          
              const Divider(thickness: 1),   
        
              UtilityComponent()             
              
            ],
          ),
        ),
      ),
    );
  }
}

 Widget logoImage(){
    return Container(
      width: 110,
      height: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://shop.innwa.com.mm/storage/site_logo/202304261655202304260951innwa_logo.png"),
          fit: BoxFit.contain,
          )
      ),
    );
  }

import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/cart/cart.dart';

import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/image_path/image_path.dart';

import '../../main.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  bool? needBackButton;
  bool needMenu;
  String? title;
  TopBar({super.key, this.needBackButton,required this.needMenu, this.title});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ImagePath imgPath = ImagePath();
  bool isMyanmar = false;
  @override
  Widget build(BuildContext context) {
  

    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 3),
            spreadRadius: -15,
            blurRadius: 14,
            color: shadowColorLight)
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            
            children: [
              widget.needBackButton!
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back_ios_sharp,size: 20,)),
                    )
                  : SizedBox(),
              widget.needMenu
              ?
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                       
                      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                        currentFocus.unfocus();
                      }
                      Scaffold.of(context).openDrawer();
                    },
                    child: Icon(Icons.menu)),
              )
              :
              SizedBox(),
              
              widget.title == null ?
              logoImage():
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(widget.title!,style: const TextStyle(
                  fontFamily: "SanFrancisco",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),),
              )
            ],
          ),
          sideUtil(context)
        ],
      ),
    );
  }

  Widget logoImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://shop.innwa.com.mm/storage/site_logo/202304261655202304260951innwa_logo.png"))),
    );
  }

  Widget sideUtil(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Cart()));
          },
          child: const SizedBox(
              width: 36, height: 36, child: Icon(Icons.shopping_cart,size: 20,)),
        ),
        Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: InkWell(
              onTap: (){
               
                setState(() {
                
                isMyanmar = !isMyanmar;
              });
              },
              child: Container(
                width: 40,
                height: 25,
                child: Center(child: Text(isMyanmar ? 'MM' : 'EN',style: TextStyle(fontFamily: "SanFrancisco",fontSize: 16.0, fontWeight: FontWeight.bold),)),
              ),
            )),
      ],
    );
  }
}

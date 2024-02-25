import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/auth/login/login.dart';
import 'package:innwa_mobile_dev/screen/auth/register/register.dart';



class Authentication extends StatefulWidget {
  // const Authenticate({ Key? key }) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

   bool showLogIn = true;

    void toggleView(){
      setState(()=> showLogIn = !showLogIn);
    }

  @override
  Widget build(BuildContext context) {
   if(showLogIn){
     return Login(toggleView: toggleView);
   }
   else {
     return Register(toggleView: toggleView,);
   }
  }
}
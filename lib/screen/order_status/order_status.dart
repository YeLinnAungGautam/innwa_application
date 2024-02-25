import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/order_status/components/order_type.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          appBar:  TopBar(needBackButton: true,needMenu: false,title: "My Order",),
          drawer: CustomDrawerWidget(onDrawerTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
                       
                      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                        currentFocus.unfocus();
                      }
          }),
          body:  Column(
            children: [             
              
              Padding(
                padding: const EdgeInsets.only(top : 10.0),
                child: OrderType(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
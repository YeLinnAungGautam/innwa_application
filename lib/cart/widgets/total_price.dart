import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        double totalPrice = 0;

        for (var cart in state.userCart) {
          final ProductDetailsPriceModel price =
              ProductDetailsPriceModel.fromJson(cart["product_price"]);
          totalPrice += (price.price.toDouble() -
                  double.parse(price.disPrice ?? "0.0") -
                  double.parse(
                    price.cashback ?? "0",
                  )) *
              cart["quantity"];
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RobotoText(
                  fontSize: 18.0,
                  fontColor: Colors.black54,
                  text: "Total Price : "),
              RobotoText(
                fontSize: 18.0,
                fontColor: Colors.black54,
                text: "${formatNumber(dbNumber: totalPrice)} MMK",
              )
            ],
          ),
        );
      },
    );
  }
}

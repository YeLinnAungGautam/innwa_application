import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/cart/widgets/item_control.dart';
import 'package:innwa_mobile_dev/product_details/model/product_details_model.dart';
import 'package:innwa_mobile_dev/shared/price_tag/price_tag.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class CartItem extends StatefulWidget {
  bool isDelete;
  bool isItemContorl;
  bool isOrderHistory;
  final Map<String, dynamic> data;
  CartItem({
    super.key,
    required this.isDelete,
    required this.isItemContorl,
    required this.isOrderHistory,
    required this.data,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      debugPrint(
          "-----------name---------------------${widget.data["product_price"]}--------------------------------");
      final ProductDetailsPriceModel price =
          ProductDetailsPriceModel.fromJson(widget.data["product_price"]);
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              spreadRadius: -3,
              blurRadius: 8,
              color: Color.fromRGBO(225, 225, 225, 1),
            )
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.data["image"],
                    width: 70.0,
                    height: 70.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalizationWidget(
                    en: widget.data["name_en"],
                    mm: widget.data["name_mm"],
                    child: (val) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RobotoText(
                          fontSize: 16.0,
                          fontColor: Colors.black,
                          text: val,
                          maxLine: 4,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PriceTag(
                              haveDiscount: price.disPrice != null,
                              text: formatNumber(
                                  dbNumber: price.price.toDouble()),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            if (price.disPrice != null)
                              PriceTag(
                                fontSize: 13,
                                text: formatNumber(
                                  dbNumber: price.price.toDouble() -
                                      double.parse(price.disPrice!) -
                                      double.parse(
                                        price.cashback ?? "0",
                                      ),
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                          ],
                        ),
                        PriceTag(
                          text: " MMK",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  !widget.isOrderHistory
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RobotoText(
                              fontSize: 13.0,
                              fontColor: Colors.black54,
                              text: "total : ${formatNumber(
                                dbNumber: (price.price.toDouble() -
                                        double.parse(price.disPrice ?? "0.0") -
                                        double.parse(
                                          price.cashback ?? "0",
                                        )) *
                                    widget.data["quantity"],
                              )} MMK"),
                        )
                      : const SizedBox(),
                  10.vertical,
                  LocalizationWidget(
                    en: "Available Quantity",
                    mm: "ရနိုင်သော ပမာဏ",
                    child: (val) {
                      return Row(
                        children: [
                          RobotoText(
                            fontSize: 13.0,
                            fontColor: Colors.black54,
                            text: "$val : ",
                            maxLine: 4,
                          ),
                          RobotoText(
                            fontSize: 13.0,
                            fontColor: Colors.black54,
                            text:
                                "${widget.data["product_price"]["stock_qty"]}",
                            maxLine: 4,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              widget.isItemContorl
                  ? ItemCountrol(
                      qty: widget.data["quantity"],
                      updateQty: () {
                        BlocProvider.of<CartBloc>(context).add(
                          AddQuantityEvent(
                            context: context,
                            productId: widget.data["product_price"]
                                ["product_id"],
                            priceId: widget.data["product_price"]["id"],
                          ),
                        );
                      },
                      reduceQty: () {
                        BlocProvider.of<CartBloc>(context).add(
                          ReduceQuantityEvent(
                            context: context,
                            productId: widget.data["product_price"]
                                ["product_id"],
                            priceId: widget.data["product_price"]["id"],
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
              widget.isDelete
                  ? GestureDetector(
                      onTap: () {
                        BlocProvider.of<CartBloc>(context).add(
                            DeleteUserCartEvent(
                                context: context,
                                productId: widget.data["product_price"]
                                    ["product_id"],
                                priceId: widget.data["product_price"]["id"]));
                      },
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 30,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      );
    });
  }
}

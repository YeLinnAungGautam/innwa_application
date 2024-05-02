import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/product_details/widgets/product_specification_section.dart';
import 'package:innwa_mobile_dev/product_details/widgets/promotion.dart';
import 'package:innwa_mobile_dev/shared/price_tag/price_tag.dart';

class ProductSpecAndPriceSelectSection extends StatelessWidget {
  const ProductSpecAndPriceSelectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...state.productDetails!.price.map(
                (e) => GestureDetector(
                  onTap: () {
                    // BlocProvider.of<ProductDetailsBloc>(context).add(
                    //     UpdateSelectedSpecEvent(context: context, id: e.id));
                  },
                  child: AbsorbPointer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: MediaQuery.of(context).size.width * 0.6,
                        constraints: const BoxConstraints(minHeight: 250),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: state.selectedSpec == e.id
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(0, 1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductPromotion(
                              price: e,
                            ),
                            10.vertical,
                            ProductSpecificationSection(data: e),
                            10.vertical,
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 5.0),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  PriceTag(
                                    text: "Price : ",
                                  ),
                                  Column(
                                    children: [
                                      PriceTag(
                                        haveDiscount: e.disPrice != null,
                                        text: formatNumber(number: e.price),
                                      ),
                                      if (e.disPrice != null)
                                        PriceTag(
                                          text: formatNumber(
                                              dbNumber: e.price -
                                                  double.parse(e.disPrice!) -
                                                  double.parse(
                                                      e.cashback ?? "0")),
                                        ),
                                    ],
                                  ),
                                  PriceTag(
                                    text: " MMK",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

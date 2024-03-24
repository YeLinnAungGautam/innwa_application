import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';

class RelatedProducts extends StatelessWidget {
  const RelatedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 350,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.relatedProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  product: state.relatedProducts[index],
                  imagePath: state.featureImagePath,
                );
              }),
        );
      },
    );
  }
}

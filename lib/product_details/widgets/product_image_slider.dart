import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        final List<String> images = [];
        if (state.productDetails!.image != null) {
          images.add(state.featureImagePath + state.productDetails!.image!);
        }
        for (var price in state.productDetails!.price) {
          for (var image in price.productImage) {
            images.add(state.productImagepath + image.image);
          }
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5, color: Colors.black26),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        images[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/home/home_banner/bloc/home_banner_bloc.dart';
import 'package:innwa_mobile_dev/home/home_banner/widgets/youtube_player.dart';

class InnwaSlider extends StatelessWidget {
  const InnwaSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBannerBloc, HomeBannerState>(
      builder: (context, state) {
        return CarouselSlider(
          items: [
            ...state.sliders.map(
              (slider) => slider.type == "Image"
                  ? CachedNetworkImage(
                      imageUrl: state.imagePath! + slider.link,
                      fit: BoxFit.fill,
                    )
                  : YoutubePlayerWidget(
                      link: slider.link,
                    ),
            ),
          ],
          options: CarouselOptions(
            aspectRatio: 20 / 10,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
          ),
        );
      },
    );
  }
}

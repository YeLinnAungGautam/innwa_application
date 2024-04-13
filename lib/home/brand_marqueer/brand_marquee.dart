import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/home/home_banner/bloc/home_banner_bloc.dart';
import 'package:marqueer/marqueer.dart';

class BrandMarquee extends StatelessWidget {
  const BrandMarquee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBannerBloc, HomeBannerState>(
      builder: (context, state) {
        return state.brandPath != null
            ? Builder(builder: (context) {
                final MarqueerController controller = MarqueerController();
                Future.delayed(const Duration(milliseconds: 300), () async {
                  if (controller.hasClients) {
                    controller.start();
                  }
                });
                return SizedBox(
                  height: 60,
                  child: Marqueer.builder(
                    itemCount: state.brands.length,
                    controller: controller,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: CachedNetworkImage(
                            imageUrl: state.brandPath! +
                                (state.brands[index].image ?? "")),
                      );
                    },
                  ),
                );
              })
            : const SizedBox();
      },
    );
  }
}

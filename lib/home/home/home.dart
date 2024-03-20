import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/home/brand_marqueer/brand_marquee.dart';
import 'package:innwa_mobile_dev/home/home_banner/bloc/home_banner_bloc.dart';
import 'package:innwa_mobile_dev/home/latest_phone/bloc/latest_phone_bloc.dart';
import 'package:innwa_mobile_dev/shared/banner/image_banner.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/slider/innwa_slider.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LatestPhoneBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      ),
      child: Builder(builder: (context) {
        BlocProvider.of<LatestPhoneBloc>(context)
          ..add(GetLatestPhoneEvent(context: context))
          ..add(GetLatestComputerEvent(context: context))
          ..add(GetLatestLaptopEvent(context: context));
        BlocProvider.of<HomeBannerBloc>(context)
          ..add(GetHomeSubBannerEvent(context: context))
          ..add(GetBrandEvent(context: context));
        return BlocBuilder<HomeBannerBloc, HomeBannerState>(
          builder: (context, state) {
            final firstBanner =
                state.subBanners.where((e) => e.bannerLocation == "1");
            final secondBanner =
                state.subBanners.where((e) => e.bannerLocation == "2");
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<LatestPhoneBloc>(context)
                  ..add(GetLatestPhoneEvent(context: context))
                  ..add(GetLatestComputerEvent(context: context))
                  ..add(GetLatestLaptopEvent(context: context));
                BlocProvider.of<HomeBannerBloc>(context)
                  ..add(GetHomeSubBannerEvent(context: context))
                  ..add(GetBrandEvent(context: context));
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: InnwaSlider(),
                  ),
                  const SliverToBoxAdapter(
                    child: BrandMarquee(),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Heading(text: "Latest Mobile Products"),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  BlocBuilder<LatestPhoneBloc, LatestPhoneState>(
                    builder: (context, state) {
                      return state.getState == ApiStatus.completed
                          ? SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.latestPhones.length,
                                (context, index) => ProductCard(
                                  product: state.latestPhones[index],
                                  imagePath: state.imagePath!,
                                ),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 0.6
                                        : 0.65,
                                crossAxisCount:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 2
                                        : 3,
                              ),
                            )
                          : const SliverToBoxAdapter(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                    },
                  ),
                  if (firstBanner.isNotEmpty)
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                  if (firstBanner.isNotEmpty &&
                      state.subBannerImagePath != null)
                    SliverToBoxAdapter(
                      child: ImageBanner(
                        url:
                            state.subBannerImagePath! + firstBanner.first.image,
                        link: firstBanner.first.link,
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Heading(text: "Latest Laptops"),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  BlocBuilder<LatestPhoneBloc, LatestPhoneState>(
                    builder: (context, state) {
                      return state.laptopGetState == ApiStatus.completed
                          ? SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.latestLaptop.length,
                                (context, index) => ProductCard(
                                  product: state.latestLaptop[index],
                                  imagePath: state.laptopImagePath!,
                                ),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 0.6
                                        : 0.65,
                                crossAxisCount:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 2
                                        : 3,
                              ),
                            )
                          : const SliverToBoxAdapter(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Heading(text: "Latest Computer Products"),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  BlocBuilder<LatestPhoneBloc, LatestPhoneState>(
                    builder: (context, state) {
                      return state.computerGetState == ApiStatus.completed
                          ? SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.latestComputer.length,
                                (context, index) => ProductCard(
                                  product: state.latestComputer[index],
                                  imagePath: state.imagePath!,
                                ),
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 0.6
                                        : 0.65,
                                crossAxisCount:
                                    MediaQuery.of(context).size.width <= 600
                                        ? 2
                                        : 3,
                              ),
                            )
                          : const SliverToBoxAdapter(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                    },
                  ),
                  if (secondBanner.isNotEmpty)
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                  if (secondBanner.isNotEmpty &&
                      state.subBannerImagePath != null)
                    SliverToBoxAdapter(
                      child: ImageBanner(
                        url: state.subBannerImagePath! +
                            secondBanner.first.image,
                        link: secondBanner.first.link,
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: 20.vertical,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
    // return SizedBox(
    //     height: MediaQuery.of(context).size.height / 1.32,
    //     child: SingleChildScrollView(
    //       padding: EdgeInsets.zero,
    //       child: Column(
    //         children: [
    //           const InnwaSlider(),
    //           Row(
    //             children: [
    //               Heading(text: "Latest Products"),
    //             ],
    //           ),
    //           GridView.count(
    //               physics: const NeverScrollableScrollPhysics(),
    //               childAspectRatio:
    //                   MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
    //               shrinkWrap: true,
    //               crossAxisCount:
    //                   MediaQuery.of(context).size.width <= 600 ? 2 : 3,
    //               semanticChildCount: 4,
    //               children: products.entries
    //                   .map((e) => ProductCard(
    //                       url: e.value["image"],
    //                       text: e.value["name"],
    //                       price: ""))
    //                   .toList()),
    //           ImageBanner(url: "url"),
    //           Row(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 10.0),
    //                 child: Heading(text: "Latest Laptops"),
    //               ),
    //             ],
    //           ),
    //           GridView.count(
    //               physics: const NeverScrollableScrollPhysics(),
    //               childAspectRatio:
    //                   MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
    //               shrinkWrap: true,
    //               crossAxisCount:
    //                   MediaQuery.of(context).size.width <= 600 ? 2 : 3,
    //               semanticChildCount: 4,
    //               children: products.entries
    //                   .map((e) => ProductCard(
    //                       url: e.value["image"],
    //                       text: e.value["name"],
    //                       price: ""))
    //                   .toList()),
    //           ImageBanner(url: "url"),
    //           Row(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 15.0),
    //                 child: Heading(text: "Latest Mobile Products"),
    //               ),
    //             ],
    //           ),
    //           GridView.count(
    //               physics: const NeverScrollableScrollPhysics(),
    //               childAspectRatio:
    //                   MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
    //               shrinkWrap: true,
    //               crossAxisCount:
    //                   MediaQuery.of(context).size.width <= 600 ? 2 : 3,
    //               semanticChildCount: 4,
    //               children: products.entries
    //                   .map((e) => ProductCard(
    //                       url: e.value["image"],
    //                       text: e.value["name"],
    //                       price: ""))
    //                   .toList()),
    //           ImageBanner(url: "url"),
    // Row(
    //   children: [
    //     Heading(text: "Latest Computer Products"),
    //   ],
    // ),
    //           GridView.count(
    //               physics: const NeverScrollableScrollPhysics(),
    //               childAspectRatio:
    //                   MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
    //               shrinkWrap: true,
    //               crossAxisCount:
    //                   MediaQuery.of(context).size.width <= 600 ? 2 : 3,
    //               semanticChildCount: 4,
    //               children: products.entries
    //                   .map((e) => ProductCard(
    //                       url: e.value["image"],
    //                       text: e.value["name"],
    //                       price: ""))
    //                   .toList()),
    //         ],
    //       ),
    //     ));
  }
}

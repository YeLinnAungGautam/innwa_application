import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/home/brand_marqueer/brand_marquee.dart';
import 'package:innwa_mobile_dev/home/home_banner/bloc/home_banner_bloc.dart';
import 'package:innwa_mobile_dev/home/latest_phone/bloc/latest_phone_bloc.dart';
import 'package:innwa_mobile_dev/shared/banner/image_banner.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/slider/innwa_slider.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/view/product_search_app_bar.dart';

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
          ..add(GetLatestComputerEvent(context: context))
          ..add(GetLatestLaptopEvent(context: context))
          ..add(GetLatestPhoneEvent(context: context))
          ..add(GetPromotionProductEvent(context: context));
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
                  ..add(GetLatestComputerEvent(context: context))
                  ..add(GetLatestLaptopEvent(context: context))
                  ..add(GetLatestPhoneEvent(context: context))
                  ..add(GetPromotionProductEvent(context: context));
                BlocProvider.of<HomeBannerBloc>(context)
                  ..add(GetHomeSubBannerEvent(context: context))
                  ..add(GetBrandEvent(context: context));
              },
              child: CustomScrollView(
                slivers: [
                  const ProductSearchAppbar(),
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
                    child: LocalizationWidget(
                      en: "Latest Mobile Products",
                      mm: "နောက်ဆုံးပေါ် မိုဘိုင်းဖုန်းများ",
                      child: (val) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15,
                              ),
                              child: RobotoText(
                                fontSize: 18,
                                fontColor: null,
                                fontWeight: FontWeight.w600,
                                text: val,
                              ),
                            ),
                          ],
                        );
                      },
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
                    child: LocalizationWidget(
                        en: "Latest Laptops",
                        mm: "နောက်ဆုံးပေါ် Laptop များ",
                        child: (val) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15,
                                ),
                                child: RobotoText(
                                  fontSize: 18,
                                  fontColor: null,
                                  fontWeight: FontWeight.w600,
                                  text: val,
                                ),
                              ),
                            ],
                          );
                        }),
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
                    child: LocalizationWidget(
                      en: "Latest Computer Products",
                      mm: "နောက်ဆုံးပေါ် ကွန်ပျူတာများ",
                      child: (val) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15,
                              ),
                              child: RobotoText(
                                fontSize: 18,
                                fontColor: null,
                                fontWeight: FontWeight.w600,
                                text: val,
                              ),
                            ),
                          ],
                        );
                      },
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
                  SliverToBoxAdapter(
                    child: LocalizationWidget(
                      en: "Promotion Products",
                      mm: "ပရိုမိုးရှင်းထုတ်ကုန်များ",
                      child: (val) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15,
                              ),
                              child: RobotoText(
                                fontSize: 18,
                                fontColor: null,
                                fontWeight: FontWeight.w600,
                                text: val,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: 15.vertical,
                  ),
                  BlocBuilder<LatestPhoneBloc, LatestPhoneState>(
                    builder: (context, state) {
                      return state.productGetState == ApiStatus.completed
                          ? SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.products.length,
                                (context, index) => ProductCard(
                                  product: state.products[index],
                                  imagePath: state.productImagePath!,
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
  }
}

import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/coupon/bloc/coupon_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/format_number.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/ui/error_retry.dart';
import 'package:intl/intl.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xfff1e3d3);
    const Color secondaryColor = Color(0xffd88c9a);
    return BlocProvider(
      create: (context) =>
          CouponBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final CouponBloc couponBloc = BlocProvider.of(context)
          ..add(GetCouponEvent(context: context));

        return Container(
          color: backgroundColorLight,
          child: SafeArea(
            child: BlocBuilder<CouponBloc, CouponState>(
              builder: (context, state) {
                return LocalizationWidget(
                    en: "Coupons",
                    mm: "ကူပွန်များ",
                    child: (coupon) {
                      return Scaffold(
                        appBar: TopBar(
                          needBackButton: true,
                          needMenu: false,
                          title: coupon,
                        ),
                        drawer: CustomDrawerWidget(onDrawerTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus &&
                              currentFocus.hasFocus) {
                            currentFocus.unfocus();
                          }
                        }),
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: state.couponStatus == ApiStatus.completed
                              ? CustomScrollView(
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child: 20.vertical,
                                    ),
                                    if (state.coupons.isEmpty)
                                      SliverToBoxAdapter(
                                        child: LocalizationWidget(
                                          en: "There is no coupon !",
                                          mm: "ကူပွန် များမရှိပါ !",
                                          child: (val) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RobotoText(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontColor: null,
                                                  text: val,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    if (state.coupons.isNotEmpty)
                                      SliverList.builder(
                                        itemCount: state.coupons.length,
                                        itemBuilder: (context, index) {
                                          final item = state.coupons[index];
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: CouponCard(
                                              height: 150,
                                              backgroundColor: primaryColor,
                                              clockwise: true,
                                              curvePosition: 135,
                                              curveRadius: 30,
                                              curveAxis: Axis.vertical,
                                              borderRadius: 10,
                                              firstChild: Container(
                                                decoration: const BoxDecoration(
                                                  color: secondaryColor,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              item.couponDisPrice !=
                                                                      null
                                                                  ? "${formatNumber(dbNumber: item.couponDisPrice)} MMK"
                                                                  : item.gift !=
                                                                          null
                                                                      ? item
                                                                          .gift!
                                                                      : "",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              item.couponDisPrice !=
                                                                      null
                                                                  ? 'Off'
                                                                  : item.gift !=
                                                                          null
                                                                      ? "Gift"
                                                                      : "",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                        color: Colors.white54,
                                                        height: 0),
                                                    const Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          '',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              secondChild: Container(
                                                width: double.maxFinite,
                                                padding:
                                                    const EdgeInsets.all(18),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Coupon Code',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      item.couponCode,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 24,
                                                        color: secondaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      'Valid Till - ${DateFormat('dd MM yyyy').format(DateTime.parse(item.endDate))}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                  ],
                                )
                              : state.couponStatus == ApiStatus.processing
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: ErrorRetry(retryFun: () {
                                        couponBloc.add(
                                            GetCouponEvent(context: context));
                                      }),
                                    ),
                        ),
                      );
                    });
              },
            ),
          ),
        );
      }),
    );
  }
}

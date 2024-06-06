import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/about_us/bloc/about_us_bloc.dart';
import 'package:innwa_mobile_dev/about_us/widgets/branch_section.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/ui/error_retry.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutUsBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      ),
      child: Builder(
        builder: (context) {
          final AboutUsBloc aboutUsBloc = BlocProvider.of<AboutUsBloc>(context)
            ..add(GetAboutUsEvent(context: context))
            ..add(GetBranchEvent(context: context));
          return BlocBuilder<AboutUsBloc, AboutUsState>(
            builder: (context, state) {
              return Scaffold(
                appBar: TopBar(
                  needBackButton: false,
                  needMenu: true,
                ),
                drawer: CustomDrawerWidget(
                  onDrawerTap: () {},
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: CustomScrollView(
                    slivers: [
                      if (state.aboutUsStatus == ApiStatus.completed)
                        SliverToBoxAdapter(
                          child: LocalizationWidget(
                            en: state.aboutUs!.titleEn,
                            mm: state.aboutUs!.titleMm,
                            child: (val) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RobotoText(
                                    fontSize: 18,
                                    fontColor: null,
                                    text: val,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: 15.vertical,
                      ),
                      if (state.aboutUsStatus == ApiStatus.processing)
                        const SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      if (state.aboutUsStatus == ApiStatus.failure)
                        SliverToBoxAdapter(
                          child: ErrorRetry(retryFun: () {
                            aboutUsBloc.add(GetAboutUsEvent(context: context));
                          }),
                        ),
                      if (state.aboutUsStatus == ApiStatus.completed)
                        SliverToBoxAdapter(
                          child: LocalizationWidget(
                              en: state.aboutUs!.descEn,
                              mm: state.aboutUs!.descMm,
                              child: (val) {
                                return HtmlWidget(val);
                              }),
                        ),
                      SliverToBoxAdapter(
                        child: 15.vertical,
                      ),
                      const SliverToBoxAdapter(
                        child: BranchSection(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/services/bloc/services_bloc.dart';
import 'package:innwa_mobile_dev/services/widgets/date_and_time_select.dart';
import 'package:innwa_mobile_dev/services/widgets/service_card.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/ui/error_retry.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ServicesBloc(BlocProvider.of<AppServiceBloc>(context).api),
      child: Builder(builder: (context) {
        final ServicesBloc servicesBloc = BlocProvider.of<ServicesBloc>(context)
          ..add(GetServiceEvent(context: context));
        return BlocBuilder<ServicesBloc, ServicesState>(
          builder: (context, state) {
            return Container(
              color: backgroundColorLight,
              child: SafeArea(
                child: Scaffold(
                  appBar: TopBar(
                    needBackButton: true,
                    needMenu: false,
                    title: "Services",
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: 20.vertical,
                        ),
                        if (state.serviceApiStatus == ApiStatus.failure)
                          SliverFillRemaining(
                            child: ErrorRetry(
                              retryFun: () {
                                servicesBloc
                                    .add(GetServiceEvent(context: context));
                              },
                            ),
                          ),
                        if (state.serviceApiStatus == ApiStatus.processing)
                          const SliverFillRemaining(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        if (state.serviceApiStatus == ApiStatus.completed)
                          SliverToBoxAdapter(
                            child: RobotoText(
                              fontSize: 18,
                              fontColor: null,
                              text: "Select Service",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (state.serviceApiStatus == ApiStatus.completed)
                          SliverToBoxAdapter(
                            child: 20.vertical,
                          ),
                        if (state.serviceApiStatus == ApiStatus.completed)
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.services.length,
                              (context, index) => GestureDetector(
                                onTap: () {
                                  servicesBloc.add(UpdateServiceEvent(
                                      context: context,
                                      service: state.services[index]));
                                },
                                child: ServiceCard(
                                  service: state.services[index],
                                  isActive: state.selectedService?.id ==
                                      state.services[index].id,
                                ),
                              ),
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:
                                  MediaQuery.of(context).size.width <= 600
                                      ? 1
                                      : 0.65,
                              crossAxisCount:
                                  MediaQuery.of(context).size.width <= 600
                                      ? 3
                                      : 3,
                            ),
                          ),
                        if (state.serviceApiStatus == ApiStatus.completed &&
                            state.selectedService != null)
                          SliverToBoxAdapter(child: 20.vertical),
                        if (state.serviceApiStatus == ApiStatus.completed &&
                            state.selectedService != null)
                          const SliverToBoxAdapter(child: DateTimeSelect())
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

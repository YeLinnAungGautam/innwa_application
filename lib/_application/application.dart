import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';
import 'package:innwa_mobile_dev/home/home_banner/bloc/home_banner_bloc.dart';
import 'package:innwa_mobile_dev/util/ui/innwa_error.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  bool haveError = false;
  Future<void> getDataInitState() async {
    final Completer<bool> sliderCompleter = Completer();
    final Completer<bool> siteCompleter = Completer();
    if (mounted) {
      BlocProvider.of<HomeBannerBloc>(context).add(
          GetHomeBannerEvent(context: context, completer: sliderCompleter));
      BlocProvider.of<AppServiceBloc>(context)
          .add(GetSitemodelEvent(context: context, completer: siteCompleter));
    }

    Future.wait([
      sliderCompleter.future,
      siteCompleter.future,
    ]).then((value) async {
      if (value[0] && value[1]) {
        setState(() {
          haveError = false;
        });
        await RouterService.of(context)
            .push(RouterPath.I.home.fullPath, redirect: true);
      } else {
        setState(() {
          haveError = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDataInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !haveError
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    UnconstrainedBox(
                      child: Image.asset(
                        Assets.logo.logoInnwa.path,

                        fit: BoxFit
                            .cover, // or any other BoxFit value as per your requirement
                      ),
                    ),
                    const Positioned(
                      bottom: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: InnwaError(
                  onClick: () async {
                    getDataInitState();
                    setState(() {
                      haveError = false;
                    });
                  },
                ),
              ),
      ),
    );
  }
}

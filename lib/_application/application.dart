import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_path.dart';
import 'package:innwa_mobile_dev/_application/router_service/router_service.dart';
import 'package:innwa_mobile_dev/_application/service/storage/storage_service.dart';
import 'package:innwa_mobile_dev/cart/bloc/cart_bloc.dart';
import 'package:innwa_mobile_dev/gen/assets.gen.dart';
import 'package:innwa_mobile_dev/home/home_banner/bloc/home_banner_bloc.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:innwa_mobile_dev/user/model/user_model.dart';
import 'package:innwa_mobile_dev/util/ui/innwa_error.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    final Completer<bool> tokenCompleter = Completer();

    final String? authToken = await StorageService.I
        .readData(key: StorageService.I.authTokenStoreKey);
    final String? loginData = await StorageService.I
        .readData(key: StorageService.I.loginDataStoreKey);
    final String? userCart =
        await StorageService.I.readData(key: StorageService.I.userCart);
    final String? localize = await StorageService.I.readData(key: "localize");
    final String? profileImagepath =
        await StorageService.I.readData(key: StorageService.I.profileImagePath);

    if (localize != null) {
      BlocProvider.of<AppServiceBloc>(context)
          .add(UpdateLocalizationEvent(context: context, data: localize));
    }

    if (mounted) {
      BlocProvider.of<HomeBannerBloc>(context).add(
          GetHomeBannerEvent(context: context, completer: sliderCompleter));
      BlocProvider.of<AppServiceBloc>(context)
          .add(GetSitemodelEvent(context: context, completer: siteCompleter));
      if (authToken != null) {
        BlocProvider.of<UserBloc>(context).add(CheckTokenValidEvent(
            context: context, token: authToken, completer: tokenCompleter));
      }
    }

    Future.wait([
      sliderCompleter.future,
      siteCompleter.future,
      if (authToken != null) tokenCompleter.future,
    ]).then((value) async {
      debugPrint(
          "-----------passs---------------------$value--------------------------------");
      debugPrint(
          "-----------passs---------------------$value--------------------------------");
      debugPrint(
          "-----------passs---------------------$value--------------------------------");
      debugPrint(
          "-----------passs---------------------$value--------------------------------");
      if (authToken != null && value[2]) {
        BlocProvider.of<AppServiceBloc>(context).api.api.myToken = authToken;
        if (loginData != null) {
          if (userCart != null) {
            BlocProvider.of<CartBloc>(context)
                .add(UpdateUserCartFromStorageEvent(context: context, data: [
              ...(jsonDecode(userCart) as List)
                  .map((e) => {...(e as Map<String, dynamic>)})
                  .toList()
            ]));
          }
          BlocProvider.of<UserBloc>(context)
            ..add(
              UpdateUserDataEvent(
                context: context,
                user: UserModel.fromJson(
                  jsonDecode(loginData),
                ),
              ),
            )
            ..add(UpdateProfileImagePathEvent(
                context: context, data: "$profileImagepath/"));
        }
      } else {
        await Future.wait([
          StorageService.I.deleteData(
            key: StorageService.I.loginDataStoreKey,
          ),
          StorageService.I.deleteData(
            key: StorageService.I.authTokenStoreKey,
          ),
          StorageService.I.deleteData(
            key: StorageService.I.loginExpireTime,
          ),
          StorageService.I.deleteData(
            key: StorageService.I.userCart,
          ),
        ]);
      }
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
                        Assets.logo.innwaLogo.path,
                        height: 90,
                        fit: BoxFit
                            .cover, // or any other BoxFit value as per your requirement
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
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

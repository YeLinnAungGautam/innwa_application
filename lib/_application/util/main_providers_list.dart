import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/home/home_banner/bloc/home_banner_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> mainProviders = [
  BlocProvider(
      create: (context) =>
          HomeBannerBloc(BlocProvider.of<AppServiceBloc>(context).api)),
];

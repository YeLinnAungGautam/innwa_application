import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/hive_constant.dart';
import 'package:innwa_mobile_dev/_application/router_service/route_config.dart';
import 'package:innwa_mobile_dev/_application/service/api_service/rest_api.dart';
import 'package:innwa_mobile_dev/_application/util/main_providers_list.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox<int>(kFavoriteBox);
  final RestAPI api = RestAPI();
  await api.init();

  runApp(MyApp(
    api: api,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.api, super.key});
  final RestAPI api;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppServiceBloc(api: api),
      child: MultiBlocProvider(
        providers: mainProviders,
        child: MaterialApp.router(
          routerConfig: routerConfig,
          title: 'Innwa IT & Mobile',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            splashColor: Colors.transparent,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}

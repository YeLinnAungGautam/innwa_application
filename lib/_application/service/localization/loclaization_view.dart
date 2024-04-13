import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';

class LocalizationWidget extends StatelessWidget {
  const LocalizationWidget({
    required this.child,
    this.en,
    this.mm,
    super.key,
  });
  final String? en;
  final String? mm;
  final Widget Function(String data) child;

  @override
  Widget build(BuildContext context) {
    final AppServiceBloc appServiceBloc =
        BlocProvider.of<AppServiceBloc>(context);
    return ValueListenableBuilder(
      valueListenable: appServiceBloc.localiztion,
      builder: (context, value, _) {
        String data = "";
        if (value == "en") {
          data = (en ?? mm) ?? "";
        } else if (value == "mm") {
          data = (mm ?? en) ?? "";
        }

        return child(data);
      },
    );
  }
}

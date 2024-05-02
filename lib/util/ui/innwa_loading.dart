import "dart:async";

import "package:flutter/material.dart";
import "package:innwa_mobile_dev/_application/router_service/route_config.dart";
import "package:innwa_mobile_dev/_application/router_service/router_service.dart";

Widget showLoadingWidget({required BuildContext context, String? title}) {
  final ColorScheme colorTheme = Theme.of(context).colorScheme;
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Center(
      child: UnconstrainedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorTheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 110,
          height: 110,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   title ?? "Test",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     decoration: TextDecoration.none,
              //     fontFamily: GoogleFonts.roboto().fontFamily,
              //     fontSize: 13,
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}

class InnwaLoading {
  InnwaLoading({required this.context, this.title});
  String? title;
  BuildContext context;
  Widget loadingWidget() {
    return showLoadingWidget(title: title, context: context);
  }

  void showLoadingSpinner() {
    unawaited(
      showDialog(
        context: rootNavigatorKey.currentState!.overlay!.context,
        builder: (context) {
          return showLoadingWidget(title: title, context: context);
        },
        barrierDismissible: false,
      ),
    );
  }

  void closeLoadingSpinner() {
    RouterService(context: rootNavigatorKey.currentState!.overlay!.context)
        .pop();
  }
}

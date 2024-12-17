import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLaunching {
  UrlLaunching._();

  static final UrlLaunching I = UrlLaunching._();

  Future<void> launchKPZPay(String? url) async {
    if (url == null || url.isEmpty) {
      debugPrint("url is null");
      return;
    }

    final Uri kpzPayUri = Uri.parse(url); // Replace with the actual scheme.

    if (await canLaunchUrl(kpzPayUri)) {
      debugPrint(" --launching $kpzPayUri --");
      await launchUrl(
        kpzPayUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint(
          "KPZ Pay app is not installed or the URL scheme is incorrect.");
    }
  }
}

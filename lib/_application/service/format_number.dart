import "package:intl/intl.dart";

String formatNumber({int? number, double? dbNumber}) =>
    NumberFormat("#,###").format(number ?? dbNumber);

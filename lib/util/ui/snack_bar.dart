import "package:flutter/material.dart";

Future<void> showSnackBar({
  required String message,
  required String title,
  required BuildContext context,
  Color? messageColor,
  Color? titleColor,
  Color? backgroundColor,
  Duration? duration,
  Widget? icon,
  Widget? suffixButton,
}) async {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      behavior: SnackBarBehavior.floating,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: titleColor ?? Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: messageColor ?? Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor ?? Colors.red.shade400,
      duration: duration ?? const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

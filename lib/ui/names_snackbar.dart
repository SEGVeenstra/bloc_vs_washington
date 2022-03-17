import 'package:flutter/material.dart';

showNamesSnackbar({
  required BuildContext context,
  required String text,
  Color? backgroundColor,
  VoidCallback? action,
  String? actionLabel,
}) {
  final bgColor = backgroundColor ?? const Color(0xFF323232);
  final fgColor = bgColor.computeLuminance() < .5 ? Colors.white : Colors.black;
  final snackBar = SnackBar(
    content: Text(
      text,
      style: TextStyle(color: fgColor),
    ),
    backgroundColor: backgroundColor,
    action: action == null
        ? null
        : SnackBarAction(
            label: actionLabel ?? 'ACTION',
            onPressed: action,
          ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

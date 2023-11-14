import 'package:flutter/material.dart';

class ProfileCardRowWidgetParam {
  const ProfileCardRowWidgetParam(
      {required this.leading,
      required this.title,
      required this.onPressed,
      this.backgroundColor,
      this.arrowColor});
  final Widget leading;
  final Widget title;
  final Color? arrowColor;
  final Color? backgroundColor;
  final Function onPressed;
}

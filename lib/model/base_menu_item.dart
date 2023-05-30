import 'package:flutter/cupertino.dart';

class BaseMenuItem {
  String? label;
  String? icon;
  GestureTapCallback? onTap;
  dynamic value;

  BaseMenuItem({
    this.label,
    this.icon,
    this.onTap,
    this.value,
  });
}

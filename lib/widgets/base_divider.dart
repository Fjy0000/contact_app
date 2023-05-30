import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constant.dart';


class BaseDivider extends StatelessWidget {

  BaseDivider({Key? key,this.color,this.height,this.left,
    this.right,this.top,this.bottom,this.boxDecoration,this.width}) : super(key: key);

  final Color? color;
  final double? height;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? width;

  final BoxDecoration? boxDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: left ?? 0,
          right: right ?? 0,
          top: top ?? 0,
          bottom: bottom ?? 0),
      width: width ?? double.infinity,
      height: height ?? 1,
      decoration: boxDecoration ?? null,
      color: boxDecoration != null ? null : color ?? Color(0xff2f3e5b),
    );
  }

}

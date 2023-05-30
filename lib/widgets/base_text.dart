import 'package:flutter/material.dart';
import '../utils/constants/constant.dart';

class BaseText extends StatelessWidget {
  final String? content;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLine;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? letterSpacing;
  final TextStyle? style;
  final List<Shadow>? shadows;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final double? lineHeight;
  final FontStyle? fontStyle;
  const BaseText(
    this.content, {
    Key? key,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.color,
    this.maxLine,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.style,
    this.shadows,
    this.fontFamily,
    this.textDecoration,
    this.lineHeight,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content ?? "",
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLine,
      overflow: overflow,
      softWrap: softWrap,
      style: style ??
          TextStyle(
            decoration: textDecoration ?? TextDecoration.none,
            color: color ?? AppTheme.WHITE_COLOR,
            fontSize: fontSize ?? 13,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontFamily: fontFamily ?? 'Poppins',
            letterSpacing: letterSpacing ?? null,
            fontStyle: fontStyle,
            shadows: shadows ?? null,
            height: lineHeight,
          ),
    );
  }
}

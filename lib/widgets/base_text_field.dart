import 'package:app2/utils/constants/constant.dart';
import 'package:flutter/material.dart';

import 'base_divider.dart';
import 'base_text.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    Key? key,
    this.baseText,
    this.hinText,
    this.width,
    this.color,
    this.textSize,
    this.height,
    this.textColor,
    this.isDisable = false,
    this.fontWeight,
    this.controller,
    this.focusNode,
    this.obscureText,
    this.readOnly,
    this.filled,
    this.hintTextColor,
    this.isUnderLine = false,
    this.baseTextColor,
    this.baseTextSize,
    this.baseFontWeight,
    this.rightLabel,
    this.prefix,
    this.postfix,
    this.decoration,
    this.contentPadding,
    this.padding,
  }) : super(key: key);

  final double? width, height;
  final Color? color;
  final double? textSize;
  final Color? textColor;
  final bool? isDisable;
  final FontWeight? fontWeight;
  final String? hinText;
  final FocusNode? focusNode;
  final bool? readOnly;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? filled;
  final Color? hintTextColor;
  final bool? isUnderLine;
  final String? baseText;
  final Color? baseTextColor;
  final double? baseTextSize;
  final FontWeight? baseFontWeight;
  final String? rightLabel;
  final Widget? prefix;
  final Widget? postfix;
  final Decoration? decoration;
  final EdgeInsets? contentPadding;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              if (baseText != null)
                Expanded(
                  child: BaseText(
                    baseText,
                    color: baseTextColor ?? AppTheme.WHITE_COLOR,
                    fontSize: baseTextSize ?? 18.0,
                    fontWeight: baseFontWeight ?? FontWeight.normal,
                  ),
                ),
              if (rightLabel != null)
                BaseText(
                  rightLabel,
                  color: baseTextColor ?? AppTheme.WHITE_COLOR,
                  fontSize: baseTextSize ?? 18.0,
                  fontWeight: baseFontWeight ?? FontWeight.normal,
                ),
            ],
          ),
        ),
        Container(
          padding: padding ??
              EdgeInsets.only(top: 19.0, bottom: 19.0, left: 15.0, right: 15.0),
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0x33e8e8e8),
              ),
          child: Row(children: [
            if (prefix != null) prefix ?? Container(),
            Expanded(
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(
                      color: textColor ?? AppTheme.WHITE_COLOR,
                      fontSize: textSize ?? 16,
                    ),
                    obscureText: obscureText ?? false,
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: contentPadding ?? EdgeInsets.zero,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      hintText: hinText ?? "",
                      hintStyle:
                          TextStyle(color: hintTextColor ?? AppTheme.HINT),
                    ),
                    readOnly: readOnly ?? false,
                    enabled: isDisable ?? true,
                    controller: controller,
                  ),
                  SizedBox(height: 5),
                  if (isUnderLine == true)
                    BaseDivider(color: Color(0xff27262C)),
                ],
              ),
            ),
            if (postfix != null) postfix ?? Container(),
          ]),
        ),
      ],
    );
  }
}

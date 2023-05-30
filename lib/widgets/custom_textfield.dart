import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/constants/constant.dart';
import 'base_divider.dart';
import 'base_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;

  // Label
  final String? label;
  final Color? labelTextColor;
  final Widget? labelPostfix;

  // Container
  final Widget? prefix;
  final Widget? postfix;
  final EdgeInsetsGeometry? paddingPrefix;
  final EdgeInsetsGeometry? paddingPostfix;
  final Decoration? decoration;

  // Text Field
  final FocusNode? focusNode;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autoFocus;

  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  // InputDecoration
  final bool removeDecoration;
  final EdgeInsetsGeometry? contentPadding;
  final bool validate;
  final String? errorText;
  final Color? cursorColor;
  final Color? focusedTextColor;

  final TextStyle? style;
  final double? fontSize;
  final Color? textColor;
  final String? hintText;
  final TextStyle? hintStyle;

  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  // Custom
  final bool customContentRequiredContainer;
  final Widget? customContent;
  final String? value;

  const CustomTextField({
    @required this.controller,
    //
    this.label,
    this.labelPostfix,
    this.labelTextColor,
    //
    this.prefix,
    this.postfix,
    this.paddingPrefix,
    this.paddingPostfix,
    this.decoration,
    //
    this.focusNode,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.textAlign,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.removeDecoration = true,
    this.contentPadding,
    this.validate = false,
    this.errorText,
    this.cursorColor,
    this.focusedTextColor,
    this.style,
    this.fontSize,
    this.textColor,
    this.hintText,
    this.hintStyle,
    this.onFocusChange,
    this.onChanged,
    this.onSubmitted,
    //
    this.customContentRequiredContainer = false,
    this.customContent,
    this.value,
    //
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: BaseText(
                      label ?? '',
                      color: labelTextColor ?? AppTheme.WHITE_COLOR,
                      fontSize: 20,
                      letterSpacing: 0.50,
                    ),
                  ),
                  if (labelPostfix != null) labelPostfix ?? Container()
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        _buildHandle()
      ],
    );
  }

  Widget _buildHandle() {
    if (controller == null) {
      if (customContent != null) {
        return customContentRequiredContainer
            ? buildContainer(customContent ?? Container())
            : (customContent ?? Container());
      }

      if (value != null) {
        return Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                if (prefix != null)
                  Padding(
                    padding: paddingPrefix ??
                        const EdgeInsets.only(
                          left: 20,
                          right: 10,
                        ),
                    child: prefix,
                  ),
                Expanded(
                  child: Padding(
                    padding: contentPadding ??
                        const EdgeInsets.symmetric(horizontal: 20),
                    child: BaseText(
                      value,
                      fontSize: 13,
                      color: textColor ?? AppTheme.WHITE_COLOR,
                    ),
                  ),
                ),
                if (postfix != null)
                  Padding(
                    padding: paddingPostfix ??
                        const EdgeInsets.only(
                          left: 10,
                          right: 20,
                        ),
                    child: postfix,
                  ),
              ],
            ),
            const SizedBox(height: 15),
            BaseDivider(),
          ],
        );
      }
    }

    return buildContainer(
      Row(
        children: [
          if (prefix != null)
            Padding(
              padding: paddingPrefix ?? const EdgeInsets.only(left: 20),
              child: prefix,
            ),
          Expanded(child: _buildTextField()),
          if (postfix != null)
            Padding(
              padding: paddingPostfix ?? const EdgeInsets.only(right: 20),
              child: postfix,
            ),
        ],
      ),
    );
  }

  Widget buildContainer(Widget childWidget) {
    return Container(
      width: double.infinity,
      decoration: decoration ??
          BoxDecoration(
            color: Color(0x33e8e8e8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0x33ffffff),
              width: 1,
            ),
          ),
      padding: customContentRequiredContainer
          ? (contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ))
          : null,
      child: childWidget,
    );
  }

  Widget _buildTextField() {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextField(
        textAlign: textAlign ?? TextAlign.start,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        //
        autofocus: autoFocus,
        readOnly: readOnly,
        enabled: enabled,
        obscureText: obscureText,
        //
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        keyboardType: keyboardType ?? TextInputType.text,
        //
        cursorColor: cursorColor,
        style: style ??
            TextStyle(
              color: textColor ?? AppTheme.WHITE_COLOR,
              fontSize: fontSize ?? 13,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
        decoration: InputDecoration(
          isDense: removeDecoration == true,
          counterText: "",
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
          errorText:
              validate == true ? errorText ?? "fill_out_this_field".tr : null,
          hintStyle: hintStyle ??
              TextStyle(
                color: AppTheme.HINT,
                fontSize: fontSize ?? 13,
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
                fontStyle: FontStyle.italic,
              ),
          hintText: hintText,
          enabledBorder: removeDecoration == true
              ? InputBorder.none
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.DIVIDER),
                ),
          focusedBorder: removeDecoration == true
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: focusedTextColor ?? Colors.red),
                ),
          errorBorder: removeDecoration == true
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: focusedTextColor ?? Colors.red),
                ),
          focusedErrorBorder: removeDecoration == true
              ? InputBorder.none
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: focusedTextColor ?? Colors.red),
                ),
          border: removeDecoration == true
              ? InputBorder.none
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.DIVIDER),
                ),
        ),
      ),
    );
  }
}

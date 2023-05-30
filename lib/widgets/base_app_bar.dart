import 'package:app2/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_text.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  BaseAppBar(this.title,
      {key,
      this.backgroundColor,
      this.actions,
      this.centerTitle,
      this.isEnableBack = true,
      this.textFontSize,
      this.textColor,
      this.elevation,
      this.bottom,
      this.titleWidget,
      this.leftWidget,
      this.leadingWidth,
      this.backButtonColor,
      this.isWithoutImage = false,
      this.backButtonBGColor})
      : super(key: key);

  final String? title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? isEnableBack;
  final Color? textColor;
  final double? textFontSize;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final Widget? titleWidget;
  final Widget? leftWidget;
  final double? leadingWidth;
  final Color? backButtonColor;
  final Color? backButtonBGColor;
  final bool isWithoutImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: isWithoutImage
          ? const BoxDecoration()
          : BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: backgroundColor ?? Color(0x14ffffff),
            ),
      child: AppBar(
        leading: leftWidget ??
            (Get.routing.route?.navigator?.canPop() == true && isEnableBack!
                ? BackButton(color: backButtonColor ?? AppTheme.WHITE_COLOR)
                : Container()),
        centerTitle: centerTitle ?? true,
        backgroundColor: backgroundColor ?? Colors.transparent,
        bottom: bottom,
        leadingWidth: leadingWidth ?? 56,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: titleWidget ??
              BaseText(
                title ?? '',
                textAlign: TextAlign.center,
                color: textColor ?? AppTheme.WHITE_COLOR,
                fontSize: 18,
                maxLine: 2,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: actions,
        elevation: elevation ?? 0,
        // systemOverlayStyle: isWithoutImage ? null: SystemUiOverlayStyle.dark, // or u
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

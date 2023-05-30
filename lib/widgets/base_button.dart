import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart';

import '../utils/constants/constant.dart';
import 'base_text.dart';

class BaseButton extends StatelessWidget {
  const BaseButton(
    this.name, {
    Key? key,
    this.onPressed,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    this.borderRadius,
    this.color,
    //
    this.textSize,
    this.textColor,
    this.isDisable = false,
  }) : super(key: key);

  final String? name;
  final VoidCallback? onPressed;

  // Container
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final double? borderRadius;

  final Color? color;

  // Text
  final double? textSize;
  final Color? textColor;

  final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(15),
        margin: margin,
        decoration: decoration ??
            (isDisable == true
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius ?? 20),
                    color: const Color(0xffC8C8C8),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius ?? 20),
                    color: color,
                    gradient: color != null
                        ? null
                        : const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xffffd600), Color(0xffff8900)],
                          ),
                  )),
        child: Center(
          child: Text(
            name ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? AppTheme.WHITE_COLOR,
              fontSize: textSize ?? 16,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

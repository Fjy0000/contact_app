import 'dart:io';
import 'package:app2/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'base_text.dart';

class BaseAvatar extends StatelessWidget {
  String? imagePath;
  String? name;
  double? height;
  double? width;
  double? fontSize;
  Color? color;

  BaseAvatar({
    this.name,
    this.height,
    this.width,
    this.imagePath,
    this.color,
    this.fontSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: height ?? 100,
        width: width ?? 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xff2575fc),
              Color(0xff6a11cb),
            ],
          ),
        ),
        child: imagePath != ""
            ? imageAsset(
                imageUrl: imagePath,
                fit: BoxFit.fill,
              )
            : Align(
                alignment: Alignment.center,
                child: BaseText(
                  getAlphabet(name ?? ''),
                  color: color ?? Colors.white,
                  fontSize: fontSize ?? 35,
                ),
              ),
      ),
    );
  }

  String getAlphabet(String name) {
    if (name.isEmpty) {
      return "-";
    }
    return name[0].toUpperCase();
  }
}

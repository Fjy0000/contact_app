import 'dart:io';
import 'package:app2/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'base_text.dart';

class CustomAvatar extends StatelessWidget {
  bool? isImageUrl;
  String? imagePath;
  double? height;
  double? width;
  double? fontSize;
  Color? color;

  CustomAvatar({
    this.isImageUrl = false,
    this.imagePath,
    this.height,
    this.width,
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
        child: imagePath != ''
            ? imageAsset(
                imageUrl: isImageUrl == true ? imagePath : null,
                file: isImageUrl == false ? File("$imagePath") : null,
                fit: BoxFit.fill,
              )
            : const Icon(
                Icons.person,
                size: 50,
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
